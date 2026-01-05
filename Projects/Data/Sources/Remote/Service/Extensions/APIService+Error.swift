//
//  APIService+Error.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

extension ApiService {
    func handleNetworkError(_ error: Error) throws -> Never {
        let remoteError = mapToRemoteNetworkError(error)
        logRemoteNetworkError(error, remoteError: remoteError)
        throw remoteError
    }
}

private extension ApiService {
    func mapToRemoteNetworkError(_ error: Error) -> RemoteNetworkError {
        switch error {
        case let urlError as URLError:
            switch urlError.code {
            case .timedOut, .networkConnectionLost:
                return .timeout
            default:
                return .urlError(urlError)
            }

        case let remoteError as RemoteNetworkError:
            return remoteError

        default:
            return .unKnownError
        }
    }
}
