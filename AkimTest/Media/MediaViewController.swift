//
//  MediaViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import SnapKit
import SDWebImage

final class MediaViewController: UIViewController {
    
    // MARK: - Variables
    private var mediaArray: [MediaModel] = []
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .mainFirstPaywall
        return refreshControl
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.addSubview(collectionView)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - Selectors
    @objc
    private func refreshData() {
        fetchData()
    }
}

// MARK: - Constraints
private extension MediaViewController {
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Network Call
private extension MediaViewController {
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] (media) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            guard let self = self, let media = media else {
                self?.showError()
                return
            }
            
            self.mediaArray = media
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ooops", message: "Failed to fetch media data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - CollectionViewDataSource
extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            return UICollectionViewCell()
        }
        
        let media = mediaArray[indexPath.item]
        cell.configure(with: media.image)
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension MediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = mediaArray[indexPath.item]
        let detailVC = DetailViewController(imageURL: media.image, videoURL: media.video)
        present(detailVC, animated: true)
    }
}

extension MediaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = UIScreen.main.bounds.width
        return CGSize(width: widthScreen * 0.9, height: widthScreen)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
