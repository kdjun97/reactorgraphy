//
//  PhotoRepository.swift
//  Data
//
//  Created by 김동준 on 1/9/26
//

import Domain
import Foundation

public class PhotoRepository: PhotoRepositoryProtocol {
    private let apiService: ApiService
    
    public init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    public func getRandomPhoto() async -> Result<PhotosModel, Error> {
        do {
            let endPoint = EndPoint<PhotoItem?>.getRandomPhoto()
            guard let response = try await apiService.call(endPoint) else {
                return .failure(NSError(domain: "", code: 1))
            }
            
            return .success(response.toDomain())
        } catch {
            return .failure(error)
        }
    }
    
    public func getPhotoList(currentIndex: Int) async -> Result<[PhotosModel], Error> {
        do {
            let queryParameters = PhotoRequest(page: String(currentIndex))
            let endPoint = EndPoint<[PhotoItem?]>.getPhotoList(queryParameters: queryParameters)
            let response = try await apiService.call(endPoint)
            
            return .success(response.compactMap { $0?.toDomain() })
        } catch {
            return .failure(error)
        }
    }
}
