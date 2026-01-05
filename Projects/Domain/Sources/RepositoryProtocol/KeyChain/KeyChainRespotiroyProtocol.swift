//
//  KeyChainRespotiroyProtocol.swift
//  Domain
//
//  Created by 김동준 on 1/5/26
//

public protocol KeyChainRespotiroyProtocol {
    func getAccessToken() -> String?
    func setAccessToken(_ accessToken: String) -> Bool
    func getSignUpCompleted() -> Bool
    func setSignUpCompleted(_ value: Bool)
}
