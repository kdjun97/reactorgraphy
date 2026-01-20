//
//  RandomPhotoItem.swift
//  Domain
//
//  Created by 김동준 on 1/8/26
//

import Foundation

public struct RandomPhotoItem: Hashable {
    public let uuid = UUID()
    public var photo: PhotosModel?
    
    public init(
        photo: PhotosModel? = nil
    ) {
        self.photo = photo
    }
}

public struct PhotosModel: Hashable {
    public let id: String
    public let width: Int
    public let height: Int
    public let description: String
    public let urls: PhotoUrl
    public let username: String
    
    public var aspectRatio: CGFloat {
        guard height > 0 else { return 1.0 }
        return CGFloat(width) / CGFloat(height)
    }
    
    public func calculatedHeight(forWidth width: CGFloat) -> CGFloat {
        return width / aspectRatio
    }
    
    public init(
        id: String = "",
        width: Int = 0,
        height: Int = 0,
        description: String = "",
        urls: PhotoUrl = .init(),
        username: String = ""
    ) {
        self.id = id
        self.width = width
        self.height = height
        self.description = description
        self.urls = urls
        self.username = username
    }
}

public struct PhotoUrl: Hashable {
    public let raw: String
    public let full: String
    public let regular: String
    public let small: String
    public let thumb: String
    public let smallS3: String
    
    public init(
        raw: String = "",
        full: String = "",
        regular: String = "",
        small: String = "",
        thumb: String = "",
        smallS3: String = ""
    ) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
        self.smallS3 = smallS3
    }
}
