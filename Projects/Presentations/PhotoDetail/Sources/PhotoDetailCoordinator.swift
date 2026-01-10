//
//  PhotoDetailCoordinator.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import Base
import Domain

public final class PhotoDetailCoordinator: BaseCoordinator {
    private let model: PhotosModel
    private weak var presenter: UIViewController?
    
    public init(model: PhotosModel) {
        self.model = model
        super.init()
        print("⭕ PhotoDetailCoordinator init!")
    }
    
    deinit {
        print("❎ PhotoDetailCoordinator deinit!")
    }
    
    public func start(presenter: UIViewController) {
        self.presenter = presenter
        let reactor = PhotoDetailReactor(model: model)
        let viewController = PhotoDetailViewController(reactor: reactor)
        viewController.modalPresentationStyle = .overFullScreen
        
        presenter.present(viewController, animated: true)
    }
}
