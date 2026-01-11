//
//  HomeReactor.swift
//  Home
//
//  Created by 김동준 on 1/10/26
//

import ReactorKit
import Domain

final class HomeReactor: Reactor {
    private let photoUseCase: PhotoUseCase
    
    init(
        photoUseCase: PhotoUseCase
    ) {
        self.photoUseCase = photoUseCase
        print("⭕ HomeReactor init!")
    }

    deinit {
        print("❎ PhotoDetailReactor deinit!")
    }
    
    let initialState: State = .init()
    
    struct State {
        var bookmarkItems: [BookmarkCardItem] = []
        var latestImageItems: [LatestImageItem] = []
    }
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setBookmarkItem([BookmarkCardItem])
        case setLatestImageItem([LatestImageItem])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let items: [BookmarkCardItem] = (0..<5).map { _ in
                BookmarkCardItem.init()
            }
            let latestImageItems: [LatestImageItem] = (0..<10).map { _ in
                LatestImageItem.init()
            }
            return .merge([
                .just(.setBookmarkItem(items)),
                .just(.setLatestImageItem(latestImageItems))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookmarkItem(let bookmarkItems):
            newState.bookmarkItems = bookmarkItems
            return newState
        case .setLatestImageItem(let latestImageItems):
            newState.latestImageItems = latestImageItems
            return newState
        }
    }
}
