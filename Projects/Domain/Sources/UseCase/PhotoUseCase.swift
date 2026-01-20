//
//  PhotoUseCase.swift
//  Domain
//
//  Created by 김동준 on 1/9/26
//

public struct PhotoUseCase {
    private let repositoryProtocol: PhotoRepositoryProtocol
    
    public init(repositoryProtocol: PhotoRepositoryProtocol) {
        self.repositoryProtocol = repositoryProtocol
    }
    
    public func getRandomPhoto() async -> Result<PhotosModel, Error> {
        return await repositoryProtocol.getRandomPhoto()
    }
    
    public func getPhotoList(currentIndex: Int) async -> Result<[PhotosModel], Error> {
        return await repositoryProtocol.getPhotoList(currentIndex: currentIndex)
    }
}
