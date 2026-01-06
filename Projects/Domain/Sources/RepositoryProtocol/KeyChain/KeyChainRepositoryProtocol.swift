//
//  KeyChainRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 1/5/26
//

public protocol KeyChainRepositoryProtocol {
    func getAccessToken() -> String?
    func setAccessToken(_ accessToken: String) -> Bool
}
