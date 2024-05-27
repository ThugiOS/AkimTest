//
//  DetailViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import PhotosUI
import Alamofire
import AmplitudeSwift

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let imageURL: URL // HEIC
    private let videoURL: URL // MOV
    private var localImageURL: URL?
    private var localVideoURL: URL?
    private var livePhoto: PHLivePhoto?
    
    private let amplitude = Amplitude(
        configuration: Configuration(
            apiKey: "57a1f30bd8288c66d25348192b0f0551"
        )
    )
    
    // MARK: - UI Components
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .mainFirstPaywall
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private lazy var livePhotoView: PHLivePhotoView = {
        let livePhotoView = PHLivePhotoView()
        livePhotoView.contentMode = .scaleAspectFill
        return livePhotoView
    }()
    
    private let closeButton: UIButton = {
        $0.layer.cornerRadius = 21
        $0.setImage(UIImage(named: "x"), for: .normal)
        $0.backgroundColor = .closeCircle
        return $0
    }(UIButton())
    
    private let previewLivePhotoButton: UIButton = {
        $0.setTitle(String(localized: "Preview"), for: .normal)
        $0.setTitleColor(.mainFirstPaywall, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        $0.layer.masksToBounds = false
        $0.isHidden = true
        return $0
    }(UIButton())
    
    private let saveLivePhotoButton: UIButton = {
        $0.setTitle(String(localized: "Save"), for: .normal)
        $0.setTitleColor(.mainFirstPaywall, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        $0.layer.masksToBounds = false
        $0.isHidden = true
        return $0
    }(UIButton())
    
    init(imageURL: URL, videoURL: URL) {
        self.imageURL = imageURL
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setLivePhoto()
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(livePhotoView)
        view.addSubview(closeButton)
        view.addSubview(previewLivePhotoButton)
        view.addSubview(saveLivePhotoButton)
        view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        
        previewLivePhotoButton.addTarget(self, action: #selector(previewLivePhotoTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        saveLivePhotoButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    private func previewLivePhotoTapped() {
        amplitude.track(
            eventType: "wallpaper_screen_action"
        )
        previewLivePhotoButton.animateButton()
        livePhotoView.startPlayback(with: .full)
    }
    
    @objc
    private func closeButtonTapped() {
        closeButton.animateButton()
        dismiss(animated: false)
    }
    
    @objc
    private func saveButtonTapped() {
        amplitude.track(
            eventType: "wallpaper_download"
        )
        saveLivePhotoButton.animateButton()
        saveLivePhotoToLibrary()
    }
}

// MARK: - Constraints
private extension DetailViewController {
    func setConstraints() {
        livePhotoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(70)
            make.height.width.equalTo(44)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        previewLivePhotoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(44)
            make.trailing.equalTo(saveLivePhotoButton.snp.leading).offset(-20)
        }
        
        saveLivePhotoButton.snp.makeConstraints { make in
            make.centerY.equalTo(previewLivePhotoButton)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(44)
            make.width.equalTo(70)
        }
    }
}

// MARK: - Create LivePhoto
private extension DetailViewController {
    private func setLivePhoto() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        downloadFile(from: imageURL) { [weak self] localURL in
            guard let self else { return }
            if let localURL {
                self.localImageURL = localURL
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        downloadFile(from: videoURL) { [weak self] localURL in
            guard let self else { return }
            if let localURL {
                self.localVideoURL = localURL
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.createLivePhoto()
            self.amplitude.track(
                eventType: "wallpaper_screen_view"
            )
        }
    }
    
    private func downloadFile(from url: URL, completion: @escaping (URL?) -> Void) {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(url, to: destination).response { [weak self] response in
            guard self != nil else { return }
            switch response.result {
            case .success(let url):
                completion(url)
            case .failure(let error):
                print("Download error: \(error)")
                completion(nil)
            }
        }
    }
    
    private func createLivePhoto() {
        guard let localImageURL = localImageURL, let localVideoURL = localVideoURL else {
            print("Local URLs are not set")
            return
        }
        
        PHLivePhoto.request(withResourceFileURLs: [localImageURL, localVideoURL], placeholderImage: nil, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill) { (livePhoto, info) in
            DispatchQueue.main.async {
                self.livePhoto = livePhoto
                self.activityIndicator.stopAnimating()
                self.livePhotoView.livePhoto = livePhoto
                self.previewLivePhotoButton.isHidden = false
                self.saveLivePhotoButton.isHidden = false
            }
        }
    }
}

// MARK: - Save LivePhoto
private extension DetailViewController {
    func saveLivePhotoToLibrary() {
        guard let livePhoto = livePhoto else { return }
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.saveLivePhoto(livePhoto)
                case .denied, .restricted:
                    self.showAlert(title: "Access Denied", message: "Access to photo library is denied or restricted.")
                case .notDetermined:
                    self.showAlert(title: "Access Not Determined", message: "Access to photo library not determined. Please try again.")
                case .limited:
                    self.showAlert(title: "Limited Access", message: "Access to a limited selection of photos is granted.")
                @unknown default:
                    fatalError("Unhandled case")
                }
            }
        }
    }
    
    func saveLivePhoto(_ livePhoto: PHLivePhoto) {
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .pairedVideo, fileURL: self.localVideoURL!, options: nil)
            creationRequest.addResource(with: .photo, fileURL: self.localImageURL!, options: nil)
        }) { [weak self] success, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.showAlert(title: "Success", message: "Live photo saved successfully.")
                } else {
                    self.showAlert(title: "Error", message: "Error saving live photo: \(error?.localizedDescription ?? "Unknown error").")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

