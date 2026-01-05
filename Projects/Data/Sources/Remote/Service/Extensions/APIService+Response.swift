//
//  APIService+Response.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

extension ApiService {
    func handleSuccessResponse<T: Decodable>(
        data: Data,
        response: URLResponse,
        endPoint: EndPoint<T>
    ) async throws -> T {
        do {
            if data.isEmpty {
                return try handleEmptyResponse()
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch let error as DecodingError {
            throw RemoteNetworkError.decodingError(error)
        } catch {
            throw RemoteNetworkError.unKnownError
        }
    }
}

private extension ApiService {
    func handleEmptyResponse<T: Decodable>() throws -> T {
        guard let emptyResponse = EmptyResponse() as? T else {
            throw RemoteNetworkError.responseDataNilError
        }
        return emptyResponse
    }
}
