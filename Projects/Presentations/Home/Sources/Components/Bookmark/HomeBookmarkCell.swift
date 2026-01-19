//
//  HomeBookmarkCell.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import UIKit
import SnapKit

final class HomeBookmarkCell: UICollectionViewCell {
    static let reuseID: String = "HomeBookmarkCell"
    private var estimatedWidth: CGFloat = 128

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let cardView: UIView = {
        let cardView = UIView()
        cardView.layer.cornerRadius = 12
        cardView.backgroundColor = .black
        
        return cardView
    }()
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {

        let attributes = layoutAttributes
        attributes.size.width = estimatedWidth
        return attributes
    }
}

private extension HomeBookmarkCell {
    func setupLayout() {
        contentView.addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeBookmarkCell {
    func configure(width: CGFloat) {
        estimatedWidth = width
    }
}
