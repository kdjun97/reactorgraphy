//
//  LatestImageCell.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import UIKit
import SnapKit

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
    }
    
    private let latestImageView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 12
        uiView.backgroundColor = .gray
        
        return uiView
    }()
}

private extension LatestImageCell {
    func setupUI() {
        contentView.backgroundColor = .orange.withAlphaComponent(0.1)
    }
    
    func setupLayout() {
        contentView.addSubview(latestImageView)
        
        latestImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

extension LatestImageCell {
    func configure() {
        // TODO: configure Cell
    }
}
