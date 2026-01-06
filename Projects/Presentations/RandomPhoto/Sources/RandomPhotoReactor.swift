//
//  RandomPhotoReactor.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/6/26
//

import ReactorKit
import Domain

final class RandomPhotoReactor: Reactor {
    private let keyChainUseCase: KeyChainUseCase
    
    struct State {
        
    }
    
    enum Mutation {
        
    }
    
    enum Action {
        
    }
    
    init(keyChainUseCase: KeyChainUseCase) {
        self.keyChainUseCase = keyChainUseCase
        print("⭕ RandomPhotoReactor init!")
    }
    
    deinit {
        print("❎ RandomPhotoReactor deinit!")
    }
    
    let initialState: State = .init()
        
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
