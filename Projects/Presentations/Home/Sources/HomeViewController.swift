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
    var bookmarkDataSource: UICollectionViewDiffableDataSource<BookmarkSection, BookmarkCollectionItem>?
    var waterfallDataSource: UICollectionViewDiffableDataSource<WaterfallSection, WaterfallCollectionItem>?
    
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
    private lazy var bookmarkCollectionView: BookmarkCollectionView = {
        let collectionView = BookmarkCollectionView()
        collectionView.setupLayoutDeleagte(self)
        
        return collectionView
    }()
    
    private lazy var waterfallCollectionView: WaterfallCollectionView = {
        let collectionView = WaterfallCollectionView()
        collectionView.setupLayoutDelegate(self)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        reactor?.action.onNext(.viewDidLoad)
    }
    
    func bind(reactor: HomeReactor) {
        makeBookmarkDataSource(reactor)
        makeWaterfallDataSource(reactor)
        
        reactor.state
            .map { $0.bookmarkItems }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.updateBookmarkSnapshot(
                    for: .bookmark,
                    items: items.map { .bookmark($0) }
                )
                self.bookmarkCollectionView.collectionViewLayout.invalidateLayout()
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.latestImageItems }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.updateWaterfallSnapshot(
                    for: .waterfall,
                    items: items.map { .waterfall($0) }
                )
                self.waterfallCollectionView.collectionViewLayout.invalidateLayout()
            })
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func makeBookmarkDataSource(_ reactor: HomeReactor) {
        bookmarkDataSource = UICollectionViewDiffableDataSource(
            collectionView: bookmarkCollectionView
        ) { [weak reactor] collectionView, indexPath, item in
            guard let reactor = reactor else { return UICollectionViewCell() }
            
            switch item {
            case .bookmark(let bookmarkCardItem):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeBookmarkCell.reuseID,
                    for: indexPath
                ) as? HomeBookmarkCell else { return UICollectionViewCell() }
                
                cell.configure(
                    width: bookmarkCardItem.width
                )
                return cell
            }
        }
        
        bookmarkDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.reuseID,
                for: indexPath
            ) as? HomeSectionHeaderView else { return nil }
            
            let section = BookmarkSection(rawValue: indexPath.section)
            switch section {
            case .bookmark:
                header.configure(title: "북마크")
            default:
                break
            }
            
            return header
        }
    }
    
    func makeWaterfallDataSource(_ reactor: HomeReactor) {
        waterfallDataSource = UICollectionViewDiffableDataSource(
            collectionView: waterfallCollectionView
        ) { [weak reactor] collectionView, indexPath, item in
            guard let reactor = reactor else { return UICollectionViewCell() }
            
            switch item {
            case .waterfall(let item):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LatestImageCell.reuseID,
                    for: indexPath
                ) as? LatestImageCell else { return UICollectionViewCell() }
                
                cell.configure(item: item)
                return cell
            }
        }
        
        waterfallDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeSectionHeaderView.waterfallReuseID,
                for: indexPath
            ) as? HomeSectionHeaderView else { return nil }
            
            let section = WaterfallSection(rawValue: indexPath.section)
            switch section {
            case .waterfall:
                header.configure(title: "최신 이미지")
            default:
                break
            }
            
            return header
        }
    }
    
    func updateBookmarkSnapshot(
        for section: BookmarkSection,
        items: [BookmarkCollectionItem]
    ) {
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<BookmarkCollectionItem>()
        sectionSnapshot.append(items)
        
        bookmarkDataSource?.apply(
            sectionSnapshot,
            to: section,
            animatingDifferences: true
        )
    }
    
    func updateWaterfallSnapshot(
        for section: WaterfallSection,
        items: [WaterfallCollectionItem]
    ) {
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<WaterfallCollectionItem>()
        sectionSnapshot.append(items)
        
        waterfallDataSource?.apply(
            sectionSnapshot,
            to: section,
            animatingDifferences: false
        )
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
        
        view.addSubview(bookmarkCollectionView)
        
        bookmarkCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(172)
        }
        
        view.addSubview(waterfallCollectionView)
        
        waterfallCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookmarkCollectionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
