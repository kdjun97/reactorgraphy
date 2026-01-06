//
//  DIContainer+.swift
//  ReactorGraphy
//
//  Created by 김동준 on 1/6/26
//

import DI
import Data
import Domain

extension DIContainer {
    func register() {
        registerKeyChainStorage()
        registerApiServiceDependency()
        
        registerKeyChainStorageDependency()
    }
}

private extension DIContainer {
    func registerKeyChainStorage() {
        let keyChainStorage = KeyChainStorage()

        container.register(KeyChainStorage.self) { _ in
            keyChainStorage
        }
        container.register(TokenProvider.self) { _ in
            keyChainStorage
        }
    }
    
    func registerApiServiceDependency() {
        container.register(ApiService.self) { resolver in
            let tokenProvider: TokenProvider = resolver.resolve()
            return ApiService(tokenProvider: tokenProvider)
        }
    }
}

private extension DIContainer {
    func registerKeyChainStorageDependency() {
        container.register(KeyChainRepositoryProtocol.self) { resolver in
            let keyChainStorage: KeyChainStorage = resolver.resolve()
            return KeyChainRepository(keyChainStorage: keyChainStorage)
        }
    }
}
