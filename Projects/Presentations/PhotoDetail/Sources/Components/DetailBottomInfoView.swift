//
//  DetailBottomInfoView.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import DesignSystem

final class DetailBottomInfoView: UIStackView {
    private let titleText: String
    private let descriptionText: String
    
    init(
        titleText: String,
        descriptionText: String
    ) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = titleText
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.text = descriptionText
        label.numberOfLines = 2
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
}

private extension DetailBottomInfoView {
    func setupUI() {
        axis = .vertical
        layoutMargins = UIEdgeInsets(
            top: 8,
            left: 20,
            bottom: 10,
            right: 20
        )
        isLayoutMarginsRelativeArrangement = true
    }
    
    func setupLayout() {
        addArrangedSubview(titleLabel)
        setCustomSpacing(4, after: titleLabel)
        
        addArrangedSubview(descriptionLabel)
        setCustomSpacing(8, after: descriptionLabel)
    }
}
