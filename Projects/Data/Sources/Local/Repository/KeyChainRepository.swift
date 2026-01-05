//
//  KeyChainRepository.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Domain

public struct KeyChainRepository: KeyChainRespotiroyProtocol {
    private let keyChainStorage: KeyChainStorage
    
    public init(keyChainStorage: KeyChainStorage) {
        self.keyChainStorage = keyChainStorage
    }
    
    public func getAccessToken() -> String? {
        return try? keyChainStorage.read(key: KeyChainStorageKeys.ACCESS_TOKEN, type: String.self)
    }

    public func setAccessToken(_ accessToken: String) -> Bool {
        do {
            try keyChainStorage.save(key: KeyChainStorageKeys.ACCESS_TOKEN, value: accessToken)
            return true
        } catch {
            return false
        }
    }
    
    public func getSignUpCompleted() -> Bool {
        return (try? keyChainStorage.read(key: KeyChainStorageKeys.SIGN_UP_COMPLETED, type: Bool.self)) ?? false
    }
    
    public func setSignUpCompleted(_ value: Bool) {
        try? keyChainStorage.save(key: KeyChainStorageKeys.SIGN_UP_COMPLETED, value: value)
    }
}
