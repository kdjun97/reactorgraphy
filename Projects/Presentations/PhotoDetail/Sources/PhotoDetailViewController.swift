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
import Kingfisher

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
    
    private lazy var detailBottomInfoView = DetailBottomInfoView(
        titleText: reactor?.currentState.model.id ?? "-",
        descriptionText: reactor?.currentState.model.description ?? "-"
    )
    
    private let photoImageView: UIImageView = UIImageView()
    private var aspectRatioConstraint: NSLayoutConstraint?

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
        
        if let url = URL(string: reactor?.currentState.model.urls.small ?? "") {
            configurePhotoImageView(url: url)
        }
    }
    
    func setupLayout() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(detailBottomInfoView)
        
        detailBottomInfoView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        let photoContainerView = UIView()
        view.addSubview(photoContainerView)
        photoContainerView.addSubview(photoImageView)
        
        photoContainerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.bottom.equalTo(detailBottomInfoView.snp.top).offset(-12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        photoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

private extension PhotoDetailViewController {
    func configurePhotoImageView(url: URL) {
        photoImageView.kf.indicatorType = .activity
        if let indicator = photoImageView.kf.indicator?.view as? UIActivityIndicatorView {
            indicator.color = .white
            indicator.style = .medium
        }
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 12
        photoImageView.clipsToBounds = true
        photoImageView.heightAnchor
            .constraint(
                equalTo: photoImageView.widthAnchor,
                multiplier: reactor?.currentState.ratio ?? 1
            )
            .isActive = true

        photoImageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.3)),
                .scaleFactor(UIScreen.main.scale),
                .cacheSerializer(FormatIndicatedCacheSerializer.jpeg)
            ]
        )
    }
}
