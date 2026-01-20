//
//  WaterfallCell.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import UIKit
import SnapKit
import Kingfisher
import Domain

final class WaterfallCell: UICollectionViewCell {
    static let reuseID: String = "WaterfallCell"

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
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
}

private extension WaterfallCell {
    func setupUI() {
        contentView.backgroundColor = .orange.withAlphaComponent(0.1)
    }
    
    func setupLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WaterfallCell {
    func configure(item: WaterfallItem) {
        guard let url = URL(string: item.model.urls.small) else { return }
        
        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
