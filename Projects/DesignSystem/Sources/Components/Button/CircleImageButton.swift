//
//  CircleImageButton.swift
//  DesignSystem
//
//  Created by 김동준 on 1/8/26
//

import UIKit
import SnapKit

public final class CircleImageButton: UIButton {
    private let image: UIImage
    private let imageColor: UIColor
    private let imageSize: CGFloat
    private let padding: NSDirectionalEdgeInsets
    private let fillColor: UIColor
    private let hasStroke: Bool
    private let action: (() -> Void)?
    
    public init(
        image: UIImage,
        imageColor: UIColor,
        imageSize: CGFloat = 24,
        padding: NSDirectionalEdgeInsets,
        fillColor: UIColor,
        hasStroke: Bool,
        action: (() -> Void)? = nil
    ) {
        self.image = image
        self.imageColor = imageColor
        self.imageSize = imageSize
        self.padding = padding
        self.fillColor = fillColor
        self.hasStroke = hasStroke
        self.action = action
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}

private extension CircleImageButton {
    func setupUI() {
        var config = UIButton.Configuration.filled()
        config.image = image
            .resized(to: CGSize(width: imageSize, height: imageSize))
            .withRenderingMode(.alwaysTemplate)
        config.baseForegroundColor = imageColor
        config.baseBackgroundColor = fillColor
        config.contentInsets = padding
        
        self.configuration = config
        self.layer.masksToBounds = true
        
        if hasStroke {
            self.layer.borderWidth = 1
            self.layer.borderColor = RColors.gray30.color.cgColor
        }
        if let action = action {
            self.addAction(
                UIAction { [weak self] _ in
                    guard let self = self else { return }
                    self.action?()
                },
                for: .touchUpInside
            )
        }
    }
}
