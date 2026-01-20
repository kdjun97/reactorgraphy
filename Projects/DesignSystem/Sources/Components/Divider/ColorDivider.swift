//
//  ColorDivider.swift
//  DesignSystem
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import SnapKit

public final class ColorDivider: UIView {
    private let color: UIColor
    
    public init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ColorDivider {
    func setupUI() {
        self.backgroundColor = color
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}
