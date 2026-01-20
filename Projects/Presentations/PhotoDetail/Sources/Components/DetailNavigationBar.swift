//
//  DetailNavigationBar.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import DesignSystem
import SnapKit

final class DetailNavigationBar: UIStackView {
    private let userName: String
    
    init(userName: String) {
        self.userName = userName
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cancelButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = RImages.icCancel.image
            .resized(to: CGSize(width: 20, height: 20))
            .withRenderingMode(.alwaysTemplate)
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        
        let button = UIButton(configuration: config)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = userName
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        
        return label
    }()
    
    let downloadButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = RImages.icDownload.image
            .resized(to: CGSize(width: 20, height: 20))
            .withRenderingMode(.alwaysTemplate)

        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseForegroundColor = .white
        
        let button = UIButton(configuration: config)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = RImages.icBookmark.image
            .resized(to: CGSize(width: 20, height: 20))
            .withRenderingMode(.alwaysTemplate)

        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseForegroundColor = .clear
        config.baseBackgroundColor = .clear
        
        let button = UIButton(configuration: config)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            updatedConfig?.baseForegroundColor = button.isSelected ? .white : .gray
            
            button.configuration = updatedConfig
        }
        
        return button
    }()
}

private extension DetailNavigationBar {
    func setupUI() {
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
    }
    
    func setupLayout() {
        self.addArrangedSubview(cancelButton)
        self.setCustomSpacing(16, after: cancelButton)

        self.addArrangedSubview(nameLabel)
        self.setCustomSpacing(8, after: nameLabel)
        
        self.addArrangedSubview(downloadButton)
        self.setCustomSpacing(4, after: downloadButton)
        
        self.addArrangedSubview(bookmarkButton)
    }
}
