//
//  MediaCell.swift
//  AkimTest
//
//  Created by Никитин Артем on 21.05.24.
//

import UIKit

final class MediaCell: UICollectionViewCell {
    static let identifier = String(describing: MediaCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    public func configure(with imageURL: URL) {
        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "questionmark"), options: .continueInBackground, completed: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addShadow()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupUI() {
        addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.layer.shadowRadius = 10

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
