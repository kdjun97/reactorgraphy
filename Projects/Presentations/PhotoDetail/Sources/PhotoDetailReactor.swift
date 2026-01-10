//
//  PhotoDetailReactor.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import ReactorKit
import Domain
import RxRelay

final public class PhotoDetailReactor: Reactor {
    public let initialState: State
    public var routeRelay = PublishRelay<Route>()
    
    public init(model: PhotosModel) {
        self.initialState = State(model: model)
        print("⭕ PhotoDetailReactor init!")
    }
    
    deinit {
        print("❎ PhotoDetailReactor deinit!")
    }
    
    
    public struct State {
        let model: PhotosModel
        var isBookmarked: Bool = false
    }
    
    public enum Action {
        case viewDidLoad
        case cancelButtonTapped
        case bookmarkButtonTapped
    }
    
    public enum Mutation {
        case setBookmark(Bool)
    }
    
    public enum Route {
        case dismiss
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        case .cancelButtonTapped:
            routeRelay.accept(.dismiss)
            return .empty()
        case .bookmarkButtonTapped:
            var value: Bool = currentState.isBookmarked
            value.toggle()
            return .just(.setBookmark(value))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookmark(let isBookmarked):
            newState.isBookmarked = isBookmarked
            return newState
        }
    }
}
