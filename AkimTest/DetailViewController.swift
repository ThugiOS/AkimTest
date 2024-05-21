//
//  DetailViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import Photos

final class DetailViewController: UIViewController {
    
    private let livePhotoView = UIImageView()
    
    private let previewLivePhotoButton: UIButton = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .red
        $0.tintColor = .white
        $0.setTitle("Preview", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return $0
    }(UIButton())
    
    private let saveLivePhotoButton: UIButton = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .red
        $0.tintColor = .white
        $0.setTitle("Save", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.addSubview(livePhotoView)
        view.addSubview(previewLivePhotoButton)
        view.addSubview(saveLivePhotoButton)
        
        previewLivePhotoButton.addTarget(self, action: #selector(previewLivePhotoTapped), for: .touchUpInside)
        saveLivePhotoButton.addTarget(self, action: #selector(saveLivePhotoButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func previewLivePhotoTapped() {
        // При нажатии этой кнопки мы отображаем на экране livePhotoView, в которой проигрывается Live Photo которое мы создали из image и video
    }
    
    @objc
    private func saveLivePhotoButtonTapped() {
        // При нажатии этой кнопки мы сохраняем live Photo в галерею, которое мы создали из image и video
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
        
        saveLivePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(previewLivePhotoButton.snp.bottom)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
}
