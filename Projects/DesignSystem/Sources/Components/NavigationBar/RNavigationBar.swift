//
//  RNavigationBar.swift
//  DesignSystem
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import SnapKit

public enum NavigationStyle {
    case logo
    case title(String)
}

public final class RNavigationBar: UIView {
    private let style: NavigationStyle
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = RImages.prographyLogo.image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let divider = ColorDivider(color: RColors.gray30.color)
    
    public init(style: NavigationStyle) {
        self.style = style
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RNavigationBar {
    func setupUI() {
        self.backgroundColor = .white
        
        switch style {
        case .logo:
            addSubview(logoImageView)
            addSubview(divider)
        case .title(let title):
            titleLabel.text = title
            addSubview(titleLabel)
        }
    }
    
    func setupLayout() {
        switch style {
        case .logo:
            logoImageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(16)
            }
            
            divider.snp.makeConstraints {
                $0.top.equalTo(logoImageView.snp.bottom).offset(16)
                $0.leading.trailing.equalToSuperview()
            }
        case .title:
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(10)
                $0.leading.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview().inset(10)
            }
        }
    }
}
