//
//  LatestImageCell.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import UIKit
import SnapKit
import Kingfisher
import Domain

final class LatestImageCell: UICollectionViewCell {
    static let reuseID: String = "LatestImageCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        latestImageView.kf.cancelDownloadTask()
        latestImageView.image = nil
    }
    
    private let latestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
}

private extension LatestImageCell {
    func setupUI() {
        contentView.backgroundColor = .orange.withAlphaComponent(0.1)
    }
    
    func setupLayout() {
        contentView.addSubview(latestImageView)
        
        latestImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LatestImageCell {
    func configure(item: LatestImageItem) {
        guard let url = URL(string: item.model.urls.small) else { return }
        
        latestImageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
