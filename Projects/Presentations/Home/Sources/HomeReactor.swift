//
//  HomeReactor.swift
//  Home
//
//  Created by 김동준 on 1/10/26
//

import ReactorKit

final class HomeReactor: Reactor {
    init() {
        print("⭕ HomeReactor init!")
    }

    deinit {
        print("❎ PhotoDetailReactor deinit!")
    }
    
    let initialState: State = .init()
    
    struct State {
        
    }
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
}
