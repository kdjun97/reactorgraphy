//
//  PhotoDetailReactor.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import ReactorKit
import Domain

final class PhotoDetailReactor: Reactor {
    init(model: PhotosModel) {
        self.initialState = State(model: model)
        print("⭕ PhotoDetailReactor init!")
    }
    
    deinit {
        print("❎ PhotoDetailReactor deinit!")
    }
    
    let initialState: State
    
    struct State {
        let model: PhotosModel
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
        return state
    }
}
