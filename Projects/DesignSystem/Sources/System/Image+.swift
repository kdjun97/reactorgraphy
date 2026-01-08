//
//  Image+.swift
//  DesignSystem
//
//  Created by 김동준 on 1/2/26
//

import UIKit

public typealias RImages = DesignSystemAsset.Images

public extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
