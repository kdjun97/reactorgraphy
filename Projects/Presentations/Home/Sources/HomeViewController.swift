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
    private var dataSource: UICollectionViewDiffableDataSource<HomeCollectionSection, HomeCollectionItem>?
    
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
    private lazy var collectionView = HomeCollectionView()
    
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
        
        reactor.state
            .map { $0.latestImageItems }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.updateSnapshot(
                    for: .latestImage,
                    items: items.map { .latestImage($0) }
                )
            })
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func makeDataSource(_ reactor: HomeReactor) {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { [weak reactor] collectionView, indexPath, item in
            guard let reactor = reactor else { return UICollectionViewCell() }
            
            switch item {
            case .bookmark(let bookmarkCardItems):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeBookmarkCell.reuseID,
                    for: indexPath
                ) as? HomeBookmarkCell else { return UICollectionViewCell() }
                
                cell.configure(
                    width: bookmarkCardItems.width
                )
                return cell
            case .latestImage(let latestImageItems):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LatestImageCell.reuseID,
                    for: indexPath
                ) as? LatestImageCell else { return UICollectionViewCell() }
                
                cell.configure()
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
            case .latestImage:
                header.configure(title: "최근 이미지")
            default:
                break
            }
            
            return header
        }
    }
    
    func sectionInitialize() {
        var initSection = NSDiffableDataSourceSnapshot<HomeCollectionSection, HomeCollectionItem>()
        initSection.appendSections([.bookmark, .latestImage])
        dataSource?.apply(initSection, animatingDifferences: false)
    }
    
    func updateSnapshot(
        for section: HomeCollectionSection,
        items: [HomeCollectionItem]
    ) {
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<HomeCollectionItem>()
        sectionSnapshot.append(items)
        
        dataSource?.apply(
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
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
