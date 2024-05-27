//
//  DetailViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

//import UIKit
//import PhotosUI
//import Alamofire
//
//final class DetailViewController: UIViewController {
//    
//    private let imageURL: URL // HEIC
//    private let videoURL: URL // MOV
//    private var localImageURL: URL?
//    private var localVideoURL: URL?
//    private var livePhoto: PHLivePhoto?
//    
//    private lazy var livePhotoView: PHLivePhotoView = {
//        let livePhotoView = PHLivePhotoView()
//        livePhotoView.contentMode = .scaleAspectFill
//        return livePhotoView
//    }()
//    
//    private let closeButton: UIButton = {
//        $0.layer.cornerRadius = 21
//        $0.setImage(UIImage(named: "x"), for: .normal)
//        $0.backgroundColor = .closeCircle
//        return $0
//    }(UIButton())
//    
//    private let previewLivePhotoButton: AnimatedGradientButton = {
//        $0.setTitle(String(localized: "Preview"), for: .normal)
//        $0.setTitleColor(.white, for: .normal)
//        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        $0.layer.cornerRadius = 12
//        $0.clipsToBounds = true
//        return $0
//    }(AnimatedGradientButton())
//    
//    private let saveButton: AnimatedGradientButton = {
//        $0.setTitle(String(localized: "Save"), for: .normal)
//        $0.setTitleColor(.white, for: .normal)
//        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        $0.layer.cornerRadius = 12
//        $0.clipsToBounds = true
//        return $0
//    }(AnimatedGradientButton())
//    
//    init(imageURL: URL, videoURL: URL) {
//        self.imageURL = imageURL
//        self.videoURL = videoURL
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        print(imageURL.description)
//        print(videoURL.description)
//        
//        setupView()
//        setConstraints()
//        
//        downloadFiles()
//    }
//    
//    private func setupView() {
//        view.backgroundColor = .white
//        view.addSubview(livePhotoView)
//        view.addSubview(closeButton)
//        view.addSubview(previewLivePhotoButton)
//        view.addSubview(saveButton)
//        
//        previewLivePhotoButton.addTarget(self, action: #selector(previewLivePhotoTapped), for: .touchUpInside)
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//    }
//    
//    private func downloadFiles() {
//        let dispatchGroup = DispatchGroup()
//        print("start download Files")
//        dispatchGroup.enter()
//        downloadFile(from: imageURL) { localURL in
//            if let localURL = localURL {
//                self.localImageURL = localURL
//            }
//            print("Image download")
//            dispatchGroup.leave()
//        }
//        
//        dispatchGroup.enter()
//        downloadFile(from: videoURL) { localURL in
//            if let localURL = localURL {
//                self.localVideoURL = localURL
//            }
//            print("Video download")
//            dispatchGroup.leave()
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            self.createLivePhoto()
//        }
//    }
//
//
//    private func downloadFile(from url: URL, completion: @escaping (URL?) -> Void) {
//        let destination: DownloadRequest.Destination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//
//        AF.download(url, to: destination).response { response in
//            switch response.result {
//            case .success(let url):
//                completion(url)
//            case .failure(let error):
//                print("Download error: \(error)")
//                completion(nil)
//            }
//        }
//    }
//
//    private func createLivePhoto() {
//        guard let localImageURL = localImageURL, let localVideoURL = localVideoURL else {
//            print("Local URLs are not set")
//            return
//        }
//        
//        print(localImageURL.debugDescription)
//        print(localVideoURL.debugDescription)
//        
//        print("Start created Live Photo")
//        
//        PHLivePhoto.request(withResourceFileURLs: [localImageURL, localVideoURL], placeholderImage: nil, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill) { (livePhoto, info) in
//            DispatchQueue.main.async {
//                self.livePhoto = livePhoto
//                self.livePhotoView.livePhoto = livePhoto
//                
//                print(self.livePhoto.debugDescription)
//            }
//        }
//    }
//    
//    @objc
//    private func previewLivePhotoTapped() {
//        livePhotoView.startPlayback(with: .full)
//    }
//    @objc
//    private func closeButtonTapped() {
//        dismiss(animated: false)
//    }
//}
//
//private extension DetailViewController {
//    func setConstraints() {
//        livePhotoView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        closeButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(24)
//            make.top.equalToSuperview().offset(70)
//        }
//        
//        previewLivePhotoButton.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-50)
//            make.leading.equalToSuperview().offset(50)
//            make.height.equalTo(44)
//            make.trailing.equalTo(saveButton.snp.leading).offset(-20)
//        }
//        
//        saveButton.snp.makeConstraints { make in
//            make.centerY.equalTo(previewLivePhotoButton)
//            make.trailing.equalToSuperview().offset(-50)
//            make.height.equalTo(44)
//            make.width.equalTo(70)
//        }
//    }
//}




















import UIKit
import PhotosUI
import Alamofire

final class DetailViewController: UIViewController {
    
    private let imageURL: URL // HEIC
    private let videoURL: URL // MOV
    private var localImageURL: URL?
    private var localVideoURL: URL?
    private var livePhoto: PHLivePhoto?
    
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
    
    private let previewLivePhotoButton: AnimatedGradientButton = {
        $0.setTitle(String(localized: "Preview"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        return $0
    }(AnimatedGradientButton())
    
    private let saveButton: AnimatedGradientButton = {
        $0.setTitle(String(localized: "Save"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        return $0
    }(AnimatedGradientButton())
    
    init(imageURL: URL, videoURL: URL) {
        self.imageURL = imageURL
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(imageURL.description)
        print(videoURL.description)
        
        setupView()
        setConstraints()
        
        downloadFiles()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(livePhotoView)
        view.addSubview(closeButton)
        view.addSubview(previewLivePhotoButton)
        view.addSubview(saveButton)
        
        previewLivePhotoButton.addTarget(self, action: #selector(previewLivePhotoTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func downloadFiles() {
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
        
        print(localImageURL.debugDescription)
        print(localVideoURL.debugDescription)
        
        print("Start created Live Photo")
        
        PHLivePhoto.request(withResourceFileURLs: [localImageURL, localVideoURL], placeholderImage: nil, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill) { (livePhoto, info) in
            DispatchQueue.main.async {
                self.livePhoto = livePhoto
                self.livePhotoView.livePhoto = livePhoto
                
                print(self.livePhoto.debugDescription)
            }
        }
    }
    
    @objc
    private func previewLivePhotoTapped() {
        livePhotoView.startPlayback(with: .full)
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc
    private func saveButtonTapped() {
        guard let livePhoto = livePhoto else { return }
        
        // Check if the app has permission to access the photo library
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    // Perform saving live photo to photo library
                    self.saveLivePhotoToLibrary(livePhoto)
                case .denied, .restricted:
                    // Handle denied or restricted access
                    // Optionally, you can show an alert to inform the user
                    print("Access to photo library denied or restricted")
                case .notDetermined:
                    // The user has not yet made a choice regarding access
                    // Optionally, you can request access again or do nothing
                    print("Access to photo library not determined")
                @unknown default:
                    fatalError("Unhandled case")
                }
            }
        }
    }

    private func saveLivePhotoToLibrary(_ livePhoto: PHLivePhoto) {
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .pairedVideo, fileURL: self.localVideoURL!, options: nil)
            creationRequest.addResource(with: .photo, fileURL: self.localImageURL!, options: nil)
        }) { [weak self] success, error in
            guard self != nil else { return }
            if success {
                print("Live photo saved successfully")
            } else {
                print("Error saving live photo: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

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
        
        previewLivePhotoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(44)
            make.trailing.equalTo(saveButton.snp.leading).offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(previewLivePhotoButton)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(44)
            make.width.equalTo(70)
        }
    }
}

