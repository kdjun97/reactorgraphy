//
//  PhotoResponse+.swift
//  Data
//
//  Created by 김동준 on 1/9/26
//

import Domain

extension PhotoItem {
    func toDomain() -> PhotosModel {
        return PhotosModel(
            id: self.id ?? "",
            width: self.width ?? 0,
            height: self.height ?? 0,
            description: self.description ?? "",
            urls: self.urls.toDomain(),
            username: self.user.toDomain()
        )
    }
}

extension PhotoUrls? {
    func toDomain() -> PhotoUrl {
        if let photoUrls = self {
            return PhotoUrl(
                raw: photoUrls.raw ?? "",
                full: photoUrls.full ?? "",
                regular: photoUrls.regular ?? "",
                small: photoUrls.small ?? "",
                thumb: photoUrls.thumb ?? "",
                smallS3: photoUrls.smallS3 ?? ""
            )
        } else {
            return PhotoUrl()
        }
    }
}

extension User? {
    func toDomain() -> String {
        if let username = self?.username {
            return username
        } else {
            return "-"
        }
    }
}
