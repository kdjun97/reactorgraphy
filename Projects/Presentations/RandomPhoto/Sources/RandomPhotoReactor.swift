//
//  RandomPhotoReactor.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/6/26
//

import ReactorKit
import Domain
import Foundation
import RxRelay

public final class RandomPhotoReactor: Reactor {
    private let keyChainUseCase: KeyChainUseCase
    private let photoUseCase: PhotoUseCase
    public let initialState: State = .init()
    public var routeRelay = PublishRelay<Route>()

    public struct State {
        var items: [RandomPhotoItem] = []
        @Pulse var scrollToIndex: Int?
    }
    
    public enum Route {
        case photoDetail(PhotosModel)
    }
    
    public enum Mutation {
        case setItems([RandomPhotoItem])
        case appendItem
        case setIndex(Int)
        case setPhotoModelToIndex(PhotosModel, Int)
    }
    
    public enum Action {
        case viewDidLoad
        case cancelButtonTapped(UUID)
        case bookmarkButtonTapped(UUID)
        case infoButtonTapped(PhotosModel?)
        case appendDummyCard
        case indexChanged(Int)
    }
    
    init(
        keyChainUseCase: KeyChainUseCase,
        photoUseCase: PhotoUseCase
    ) {
        self.keyChainUseCase = keyChainUseCase
        self.photoUseCase = photoUseCase
        print("⭕ RandomPhotoReactor init!")
    }
    
    deinit {
        print("❎ RandomPhotoReactor deinit!")
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
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
        case .infoButtonTapped(let model):
            guard let model = model else { return .empty() }
            routeRelay.accept(.photoDetail(model))
            return .empty()
        case .appendDummyCard:
            return .just(.appendItem)
        case .indexChanged(let index):
            guard index < currentState.items.count else { return .empty() }
            
            let photoModel = currentState.items[index]
            guard let _ = photoModel.photo else {
                return fetchRandomPhotoStream(index: index)
            }
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
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
        case let .setPhotoModelToIndex(model, index):
            guard let _ = currentState.items[index].photo else {
                newState.items[index].photo = model
                return newState
            }
            
            return state
        }
    }
}

private extension RandomPhotoReactor {
    func fetchRandomPhotoStream(index: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            let task = Task {
                guard let self = self else { return }
                let result = await self.photoUseCase.getRandomPhoto()
                
                switch result {
                case .success(let model):
                    observer.onNext(.setPhotoModelToIndex(model, index))
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create { task.cancel() }
        }
    }
}
