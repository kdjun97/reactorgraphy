//
//  PhotoRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 1/9/26
//

public protocol PhotoRepositoryProtocol {
    func getRandomPhoto() async -> Result<PhotosModel, Error>
    func getPhotoList(currentIndex: Int) async -> Result<[PhotosModel], Error>
}
