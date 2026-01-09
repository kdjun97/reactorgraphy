//
//  RandomPhotoReactor.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/6/26
//

import ReactorKit
import Domain
import Foundation

final class RandomPhotoReactor: Reactor {
    private let keyChainUseCase: KeyChainUseCase
    
    struct State {
        var items: [RandomPhotoItem] = []
        @Pulse var scrollToIndex: Int?
    }
    
    enum Mutation {
        case setItems([RandomPhotoItem])
        case appendItem
        case setIndex(Int)
    }
    
    enum Action {
        case onAppear
        case cancelButtonTapped(UUID)
        case bookmarkButtonTapped(UUID)
        case infoButtonTapped(UUID)
        case appendDummyCard
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
        case .onAppear:
            let items = (0..<2).map { _ in RandomPhotoItem() }
            return .just(.setItems(items))
        case .cancelButtonTapped(let uuid):
            print("cancel button tapped! \(uuid)")
            return .empty()
        case .bookmarkButtonTapped(let uuid):
            guard let currentIndex = currentState.items.firstIndex(where:{ $0.uuid == uuid }) else { return .empty() }
            let nextIndex = currentIndex+1
            
            if nextIndex == currentState.items.count {
                return .concat([
                    .just(.appendItem),
                    .just(.setIndex(nextIndex))
                ])
            } else if nextIndex < currentState.items.count {
                return .just(.setIndex(nextIndex))
            }
            
            return .empty()
        case .infoButtonTapped(let uuid):
            print("info button button tapped! \(uuid)")
            return .empty()
        case .appendDummyCard:
            return .just(.appendItem)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setItems(let items):
            newState.items = items
            return newState
        case .appendItem:
            newState.items.append(RandomPhotoItem())
            return newState
        case .setIndex(let value):
            newState.scrollToIndex = value
            return newState
        }
    }
}
