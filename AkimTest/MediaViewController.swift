//
//  MediaViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit
import SnapKit

final class MediaViewController: UIViewController {
    
    // MARK: - Variables
    private var mediaArray: [MediaModel] = []
    private var imageCache: [URL: UIImage] = [:]
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchData()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = .yellow
        view.addSubview(collectionView)
    }
    
    // MARK: - Network Call
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] (media) in
            guard let media = media else { return }
            self?.mediaArray = media
            self?.downloadImages()
        }
    }
    
    private func downloadImages() {
        let dispatchGroup = DispatchGroup()
        
        for media in mediaArray {
            dispatchGroup.enter()
            downloadImage(from: media.image) { [weak self] (image) in
                if let image = image {
                    self?.imageCache[media.image] = image
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
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

extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            return UICollectionViewCell()
        }
        
        let media = mediaArray[indexPath.item]
        if let image = imageCache[media.image] {
            cell.configure(with: image)
        } else {
            cell.configure(with: nil)
            downloadImage(from: media.image) { [weak self, weak cell] (image) in
                guard let self = self, let image = image else { return }
                self.imageCache[media.image] = image
                DispatchQueue.main.async {
                    guard let index = collectionView.indexPath(for: cell!)?.item, index == indexPath.item else {
                        return
                    }
                    cell?.configure(with: image)
                }
            }
        }
        return cell
    }
}

extension MediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sewq")
        let media = mediaArray[indexPath.item]
        let detailVC = DetailViewController(imageURL: media.image, videoURL: media.video)
        present(detailVC, animated: true)
    }
}

extension MediaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}



final class MediaCell: UICollectionViewCell {
    static let identifier = String(describing: MediaCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()
    
    public func configure(with image: UIImage?) {
        self.imageView.image = image ?? UIImage(systemName: "questionmark")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
