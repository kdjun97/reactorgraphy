//
//  KeyChainUseCase.swift
//  Domain
//
//  Created by 김동준 on 1/6/26
//

public struct KeyChainUseCase {
    private let repositoryProtocol: KeyChainRepositoryProtocol
    
    public init(repositoryProtocol: KeyChainRepositoryProtocol) {
        self.repositoryProtocol = repositoryProtocol
    }
    
    public func setAccessToken(_ accessToken: String) -> Bool {
        repositoryProtocol.setAccessToken(accessToken)
    }
    
    public func getAccessToken() -> String? {
        return repositoryProtocol.getAccessToken()
    }
}
