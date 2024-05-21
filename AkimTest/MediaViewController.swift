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
    private var media: [MediaItem] = []
    
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
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = .yellow
        view.addSubview(collectionView)
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
        media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            fatalError()
        }
    }
}

extension MediaViewController: UICollectionViewDelegate {
    
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


struct MediaItem: Codable {
    let image: URL
    let video: URL
}


final class MediaCell: UICollectionViewCell {
    static let identifier = String(describing: MediaCell.self)
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "questionmark")
        $0.tintColor = .white
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    public func mediaCellConfigure(with image: UIImage) {
        self.imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
