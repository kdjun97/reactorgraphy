//
//  RandomPhotoItem.swift
//  Domain
//
//  Created by 김동준 on 1/8/26
//

import Foundation

public struct RandomPhotoItem: Hashable {
    public let uuid = UUID()
    public var photo: Photo?
    
    public init(
        photo: Photo? = nil
    ) {
        self.photo = photo
    }
}

public struct Photo: Hashable {
    public let temp: String
}
