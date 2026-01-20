//
//  KeyChainStorage+TokenProvider.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

extension KeyChainStorage: TokenProvider {
    public func getAccessToken() -> String {
        return (try? read(key: KeyChainStorageKeys.ACCESS_TOKEN, type: String.self)) ?? ""
    }
    
    public func setAccessToken(_ accessToken: String) {
        try? save(key: KeyChainStorageKeys.ACCESS_TOKEN, value: accessToken)
    }
}
