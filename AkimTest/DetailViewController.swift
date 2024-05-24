//
//  DetailViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import PhotosUI

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
    }
    
    private func downloadFiles() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        downloadFile(from: imageURL) { localURL in
            if let localURL = localURL {
                self.localImageURL = localURL
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        downloadFile(from: videoURL) { localURL in
            if let localURL = localURL {
                self.localVideoURL = localURL
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.createLivePhoto()
        }
    }
    
    private func downloadFile(from url: URL, completion: @escaping (URL?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            guard let localURL = localURL, error == nil else {
                print("Download error: \(String(describing: error))")
                completion(nil)
                return
            }
            
            // Move the file to a permanent location
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            
            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.moveItem(at: localURL, to: destinationURL)
                completion(destinationURL)
            } catch {
                print("File move error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func createLivePhoto() {
        guard let localImageURL = localImageURL, let localVideoURL = localVideoURL else {
            print("Local URLs are not set")
            return
        }
        
        PHLivePhoto.request(withResourceFileURLs: [localImageURL, localVideoURL], placeholderImage: nil, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill) { (livePhoto, info) in
            DispatchQueue.main.async {
                self.livePhoto = livePhoto
                self.livePhotoView.livePhoto = livePhoto
            }
        }
    }
    
    @objc
    private func previewLivePhotoTapped() {
        print(localImageURL?.debugDescription)
        print(localVideoURL?.debugDescription)
        livePhotoView.startPlayback(with: .full)
    }
    @objc
    private func closeButtonTapped() {
        dismiss(animated: false)
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
