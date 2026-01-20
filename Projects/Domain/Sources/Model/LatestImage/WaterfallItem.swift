//
//  LatestImageItem.swift
//  Domain
//
//  Created by 김동준 on 1/11/26
//

import Foundation

public struct WaterfallItem: Hashable {
    public let uuid = UUID()
    public let model: PhotosModel
    
    public init(model: PhotosModel) {
        self.model = model
    }
}
