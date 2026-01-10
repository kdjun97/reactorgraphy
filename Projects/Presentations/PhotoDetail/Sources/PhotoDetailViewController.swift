//
//  PhotoDetailViewController.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa

final class PhotoDetailViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    init(reactor: PhotoDetailReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        print("⭕ PhotoDetailViewController init!")
    }
    
    deinit {
        print("❎ PhotoDetailViewController deinit!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationBar = DetailNavigationBar(userName: reactor?.currentState.model.username ?? "-")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }

    func bind(reactor: PhotoDetailReactor) {
        navigationBar.cancelButton.rx.tap
            .map { PhotoDetailReactor.Action.cancelButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationBar.bookmarkButton.rx.tap
            .map { PhotoDetailReactor.Action.bookmarkButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isBookmarked }
            .distinctUntilChanged()
            .bind(to: navigationBar.bookmarkButton.rx.isSelected)
            .disposed(by: disposeBag)
    }
}

private extension PhotoDetailViewController {
    func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
    
    func setupLayout() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
