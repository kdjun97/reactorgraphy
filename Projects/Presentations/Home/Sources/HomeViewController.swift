//
//  HomeViewController.swift
//  Home
//
//  Created by 김동준 on 12/31/25
//

import UIKit
import SnapKit
import ReactorKit
import Domain
import DesignSystem

final class HomeViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    var dataSource: UICollectionViewDiffableDataSource<HomeCollectionSection, HomeCollectionItem>?
    
    init(reactor: HomeReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        print("⭕ HomeViewController init!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("❎ HomeViewController deinit!")
    }
    
    private let navigationBar: RNavigationBar = .init(style: .logo)
    private lazy var collectionView: HomeCollectionView = {
        let collectionView = HomeCollectionView()
        collectionView.homeCollectionViewLayout.waterfallDelegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        reactor?.action.onNext(.viewDidLoad)
    }
    
    func bind(reactor: HomeReactor) {
        makeDataSource(reactor)
        
        reactor.state
            .map { state in
                HomeSnapshotState(
                    bookmarks: state.bookmarkItems,
                    waterfalls: state.latestImageItems
                )
            }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] snapshotState in
                guard let self = self else { return }
                self.updateSnapshot(
                    bookmarks: snapshotState.bookmarks,
                    waterfalls: snapshotState.waterfalls
                )
            })
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func makeDataSource(_ reactor: HomeReactor) {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return UICollectionViewCell() }
            
            switch item {
            case .bookmarkRow(let cardRowItems):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeBookmarkRowCell.reuseID,
                    for: indexPath
                ) as? HomeBookmarkRowCell else { return UICollectionViewCell() }
                
                cell.configure(items: cardRowItems)
                return cell
            case .waterfall(let photo):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LatestImageCell.reuseID,
                    for: indexPath
                ) as? LatestImageCell else { return UICollectionViewCell() }
                
                cell.configure(item: photo)
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }

            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.reuseID,
                for: indexPath
            ) as? HomeSectionHeaderView else { return nil }
            
            let section = HomeCollectionSection(rawValue: indexPath.section)
            switch section {
            case .bookmark:
                header.configure(title: "북마크")
            case .waterfall:
                header.configure(title: "최신 이미지")
            case .none:
                break
            }
            
            return header
        }
    }
    
    func updateSnapshot(
        bookmarks: [BookmarkCardItem],
        waterfalls: [LatestImageItem]
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeCollectionSection, HomeCollectionItem>()
        
        snapshot.appendSections([.bookmark, .waterfall])
        
        if !bookmarks.isEmpty {
            snapshot.appendItems(
                [.bookmarkRow(bookmarks)],
                toSection: .bookmark
            )
        }
        
        snapshot.appendItems(
            waterfalls.map { .waterfall($0) },
            toSection: .waterfall
        )
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
        collectionView.homeCollectionViewLayout.invalidateLayout()
    }
}

private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
