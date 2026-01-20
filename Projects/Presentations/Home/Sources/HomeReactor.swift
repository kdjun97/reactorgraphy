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
        var waterfallItems: [WaterfallItem] = []
        var currentIndex: Int = 1
    }
    
    enum Action {
        case viewDidLoad
        case fetchPhotoList
    }
    
    enum Mutation {
        case setBookmarkItem([BookmarkCardItem])
        case setWaterfallItem([WaterfallItem])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBookmarkItem(let bookmarkItems):
            newState.bookmarkItems = bookmarkItems
            return newState
        case .setWaterfallItem(let waterfallItems):
            if currentState.waterfallItems.isEmpty {
                newState.waterfallItems = waterfallItems
                return newState
            }
            let isLastPage = compareLastPage(
                storedList: currentState.waterfallItems,
                receivedList: waterfallItems
            )
            
            if !isLastPage {
                newState.currentIndex = currentState.currentIndex + 1
                newState.waterfallItems += waterfallItems
            }
            
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
                print("## API Call")
                switch result {
                case .success(let photoModels):
                    let waterfallItems = photoModels.map { WaterfallItem(model: $0) }
                    observer.onNext(.setWaterfallItem(waterfallItems))
                case .failure(let error):
                    observer.onError(error) // 일단 Error에 대한 UI처리나 아무것도 고려 없이, onError를 던지게 구현. 추후는 error UI 핸들링
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
