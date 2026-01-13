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
    private var bookmarkDataSource: UICollectionViewDiffableDataSource<BookmarkSection, BookmarkCollectionItem>?
    
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
    private lazy var bookmarkCollectionView = BookmarkCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        sectionInitialize()
        reactor?.action.onNext(.viewDidLoad)
    }
    
    func bind(reactor: HomeReactor) {
        makeDataSource(reactor)
        
        reactor.state
            .map { $0.bookmarkItems }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.updateSnapshot(
                    for: .bookmark,
                    items: items.map { .bookmark($0) }
                )
            })
            .disposed(by: disposeBag)
        
//        reactor.state
//            .map { $0.latestImageItems }
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] items in
//                guard let self = self else { return }
//                self.updateSnapshot(
//                    for: .latestImage,
//                    items: items.map { .latestImage($0) }
//                )
//            })
//            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func makeDataSource(_ reactor: HomeReactor) {
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
    
    func sectionInitialize() {
        var initSection = NSDiffableDataSourceSnapshot<BookmarkSection, BookmarkCollectionItem>()
        initSection.appendSections([.bookmark])
        bookmarkDataSource?.apply(initSection, animatingDifferences: false)
    }
    
    func updateSnapshot(
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
            $0.bottom.equalToSuperview()
        }
    }
}
