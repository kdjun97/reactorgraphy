//
//  WaterfallCell.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import UIKit
import SnapKit
import Kingfisher
import Domain
import RxRelay
import RxSwift

final class WaterfallCell: UICollectionViewCell {
    static let reuseID: String = "WaterfallCell"
    let cellRelay = PublishRelay<Void>()
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        disposeBag = DisposeBag()
        bind()
    }
    
    private let buttonContainer: UIButton = .init()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private func bind() {
        buttonContainer.rx.tap
            .bind(to: cellRelay)
            .disposed(by: disposeBag)
    }
}

private extension WaterfallCell {
    func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(buttonContainer)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        buttonContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WaterfallCell {
    func configure(item: WaterfallItem) {
        guard let url = URL(string: item.model.urls.small) else { return }
        
        imageView.kf.indicatorType = .activity
        if let indicator = imageView.kf.indicator?.view as? UIActivityIndicatorView {
            indicator.color = .white
            indicator.style = .medium
        }

        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
}
