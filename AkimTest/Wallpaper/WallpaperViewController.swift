//
//  WallpaperViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import SnapKit
import SDWebImage

final class WallpaperViewController: UIViewController {
    
    // MARK: - Variables
    private var mediaArray: [WallpaperModel] = []
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(WallpaperCell.self, forCellWithReuseIdentifier: WallpaperCell.identifier)
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
private extension WallpaperViewController {
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Network Call

private extension WallpaperViewController {
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            
            guard let self = self else { return }
            
            switch result {
            case .success(let media):
                self.mediaArray = media
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure:
                self.showError()
            }
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ooops", message: "Failed to fetch media data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alert, animated: true)
        }
    }
}

// MARK: - CollectionViewDataSource
extension WallpaperViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.identifier, for: indexPath) as? WallpaperCell else {
            return UICollectionViewCell()
        }
        
        let media = mediaArray[indexPath.item]
        cell.configure(with: media.image)
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension WallpaperViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = mediaArray[indexPath.item]
        let detailVC = DetailViewController(imageURL: media.image, videoURL: media.video)
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        present(detailVC, animated: false)
    }
}

extension WallpaperViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = UIScreen.main.bounds.width
        return CGSize(width: widthScreen * 0.9, height: widthScreen)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
