//
//  DetailViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    private let imageURL: URL // HEIC https://wall.appthe.club/media/2.HEIC
    private let videoURL: URL // mov https://wall.appthe.club/media/2.mov
    private var livePhoto: PHLivePhoto?
    
    private lazy var livePhotoView: PHLivePhotoView = {
        let livePhotoView = PHLivePhotoView()
        livePhotoView.contentMode = .scaleAspectFit
        return livePhotoView
    }()
    
    private let previewLivePhotoButton: UIButton = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .red
        $0.tintColor = .white
        $0.setTitle("Preview", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        $0.isHidden = true
        return $0
    }(UIButton())
    
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
        
        createLivePhoto()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(livePhotoView)
        view.addSubview(previewLivePhotoButton)
        
        previewLivePhotoButton.addTarget(self, action: #selector(previewLivePhotoTapped), for: .touchUpInside)
    }
    
    private func createLivePhoto() {
        DispatchQueue.main.async {
            // here you need to create a Live Photo
            print("Live photo was created")
            // If Live Photo was created, we make the previewLivePhotoButton active.
            if self.livePhoto != nil {
                self.previewLivePhotoButton.isHidden = false
            }
        }
    }
    
    @objc
    private func previewLivePhotoTapped() {
        if let livePhoto {
            livePhotoView.livePhoto = livePhoto
        }
    }
}

private extension DetailViewController {
    func setConstraints() {
        livePhotoView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        previewLivePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(livePhotoView.snp.bottom)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
}


