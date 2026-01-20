//
//  RandomPhotoViewController.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import SnapKit
import ReactorKit
import DesignSystem
import Domain
import RxCocoa

final class RandomPhotoViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<RandomPhotoCellSection, RandomPhotoItem>?
    
    init(reactor: RandomPhotoReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        print("⭕ RandomPhotoViewController init!")
    }
    
    deinit {
        print("❎ RandomPhotoViewController deinit!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navigationBar: RNavigationBar = .init(style: .logo)
    private lazy var collectionView = CarouselCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        reactor?.action.onNext(.viewDidLoad)
        collectionView.delegate = self
    }
    
    func bind(reactor: RandomPhotoReactor) {
        makeDataSource(reactor)
        
        reactor.state
            .map { $0.items }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<RandomPhotoCellSection, RandomPhotoItem>()
                snapshot.appendSections([.main])
                snapshot.appendItems(items)
                dataSource?.apply(snapshot, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$scrollToIndex)
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                collectionView.scrollToItem(
                    at: IndexPath(item: index, section: 0),
                    at: .centeredHorizontally,
                    animated: true
                )
            })
            .disposed(by: disposeBag)
        
        collectionView.currentIndexRelay
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { RandomPhotoReactor.Action.indexChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

private extension RandomPhotoViewController {
    func makeDataSource(_ reactor: RandomPhotoReactor) {
        dataSource = UICollectionViewDiffableDataSource<RandomPhotoCellSection, RandomPhotoItem>(
            collectionView: collectionView
        ) { [weak reactor] collectionView, indexPath, item in
            guard let reactor = reactor,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RandomPhotoCell.reuseID,
                    for: indexPath
                  ) as? RandomPhotoCell else { return UICollectionViewCell() }
            
            // Closure로 액션 컨트롤 하는 방법 연습
            cell.configure(
                imageURL: item.photo?.urls.small,
                onCancel: {
                    reactor.action.onNext(.cancelButtonTapped(item.uuid))
                }
            )
            
            cell.bookmarkButtonStream // Relay 로 방출되는 액션 잡아서 처리하는 방법 연습
                .map { RandomPhotoReactor.Action.bookmarkButtonTapped(item.uuid) }
                .subscribe(reactor.action)
                .disposed(by: cell.disposeBag)
            
            cell.buttonContainer.infoButton.rx.tap // ReactorKit 방식으로 depth까지 들어가서 액션 컨트롤 하는 방법 연습
                .map { RandomPhotoReactor.Action.infoButtonTapped(item.photo) }
                .bind(to: reactor.action)
                .disposed(by: cell.disposeBag)
            return cell
        }
    }
}

private extension RandomPhotoViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        setupNavigationBarLayout()
        setupCarouselLayout()
    }
    
    func setupNavigationBarLayout() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setupCarouselLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension RandomPhotoViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let totalItems = collectionView.numberOfItems(inSection: 0)
        if (totalItems > 0) && indexPath.item == totalItems - 1 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.reactor?.action.onNext(.appendDummyCard)
            }
        }
    }
}
