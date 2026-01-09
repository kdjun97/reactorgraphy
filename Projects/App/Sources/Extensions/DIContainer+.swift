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
        registerKeyChainUseCase()
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
            return ApiService(tokenProvider: resolver.resolve())
        }
        
        container.register(PhotoRepositoryProtocol.self) { resolver in
            return PhotoRepository(apiService: resolver.resolve())
        }
        
        container.register(PhotoUseCase.self) { resolver in
            return PhotoUseCase(repositoryProtocol: resolver.resolve())
        }
    }
}

private extension DIContainer {
    func registerKeyChainStorageDependency() {
        container.register(KeyChainRepositoryProtocol.self) { resolver in
            return KeyChainRepository(keyChainStorage: resolver.resolve())
        }
    }
    
    func registerKeyChainUseCase() {
        container.register(KeyChainUseCase.self) { resolver in
            return KeyChainUseCase(repositoryProtocol: resolver.resolve())
        }
    }
}
