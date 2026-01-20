//
//  HomeReactor.swift
//  Home
//
//  Created by 김동준 on 1/10/26
//

import ReactorKit
import Domain
import RxRelay

final public class HomeReactor: Reactor {
    private let photoUseCase: PhotoUseCase
    
    public init(
        photoUseCase: PhotoUseCase
    ) {
        self.photoUseCase = photoUseCase
        print("⭕ HomeReactor init!")
    }

    deinit {
        print("❎ PhotoDetailReactor deinit!")
    }
    
    public let initialState: State = .init()
    public var routeRelay = PublishRelay<Route>()
    
    public struct State {
        var bookmarkItems: [BookmarkCardItem] = []
        var waterfallItems: [WaterfallItem] = []
        var currentIndex: Int = 1
        var isLoading: Bool = false
    }
    
    public enum Route {
        case photoDetail(PhotosModel)
    }
    
    public enum Action {
        case viewDidLoad
        case fetchPhotoList
        case loadNextPage
        case didPhotoTapped(HomeCollectionItem)
    }
    
    public enum Mutation {
        case setBookmarkItem([BookmarkCardItem])
        case setWaterfallItem([WaterfallItem])
        case setLoading(Bool)
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let items: [BookmarkCardItem] = (0..<5).map { _ in
                BookmarkCardItem.init()
            }
            return .merge([
                .just(.setBookmarkItem(items)),
                fetchPhotoList(currentIndex: 1)
            ])
        case .fetchPhotoList:
            let index = currentState.currentIndex + 1
            return fetchPhotoList(currentIndex: index)
        case .loadNextPage:
            let nextIndex = currentState.currentIndex + 1
            return .concat([
                .just(.setLoading(true)),
                fetchPhotoList(currentIndex: nextIndex),
                .just(.setLoading(false))
            ])
        case .didPhotoTapped(let selectionItem):
            switch selectionItem {
            case .bookmarkRow:
                return .empty()
            case .waterfall(let item):
                routeRelay.accept(.photoDetail(item.model))
                return .empty()
            }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookmarkItem(let bookmarkItems):
            newState.bookmarkItems = bookmarkItems
            return newState
        case .setWaterfallItem(let waterfallItems):
            if state.waterfallItems.isEmpty {
                newState.waterfallItems = waterfallItems
                return newState
            }
            let isLastPage = compareLastPage(
                storedList: state.waterfallItems,
                receivedList: waterfallItems
            )
            
            if !isLastPage {
                newState.currentIndex = state.currentIndex + 1
                newState.waterfallItems += waterfallItems
            }
            
            return newState
        case .setLoading(let value):
            newState.isLoading = value
            return newState
        }
    }
}

private extension HomeReactor {
    func fetchPhotoList(currentIndex: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            let task = Task {
                guard let self = self else { return }
                let result = await self.photoUseCase.getPhotoList(currentIndex: currentIndex)
                switch result {
                case .success(let photoModels):
                    let waterfallItems = photoModels.map { WaterfallItem(model: $0) }
                    observer.onNext(.setWaterfallItem(waterfallItems))
                case .failure:
                    observer.onNext(.setLoading(false)) // MARK: 에러 처리는 하지 않았음.
                }
                observer.onCompleted()
            }
            return Disposables.create { task.cancel() }
        }
    }
}

private extension HomeReactor {
    func compareLastPage(
        storedList: [WaterfallItem],
        receivedList: [WaterfallItem]
    ) -> Bool {
        if let receivedPhotosLastIndexId = receivedList.last?.uuid,
           let storedPhotosLastIndexId = storedList.last?.uuid {
            return (receivedPhotosLastIndexId == storedPhotosLastIndexId)
        } else {
            return false
        }
    }
}
