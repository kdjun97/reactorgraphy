//
//  RandomPhotoCell.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/7/26
//

import UIKit
import DesignSystem
import RxSwift
import Kingfisher

final class RandomPhotoCell: UICollectionViewCell {
    static let reuseID = "RandomPhotoCellID"
    var disposeBag = DisposeBag()
    var bookmarkButtonStream: Observable<Void> {
        buttonContainer.bookmarkRelay.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buttonContainer.didTapCancelButton = nil
        disposeBag = DisposeBag()
        
        photoImageView.kf.cancelDownloadTask()
        photoImageView.image = nil
    }
    
    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    let photoImageView: UIImageView = UIImageView()
    let buttonContainer = RandomPhotoBottomStackView()
}

private extension RandomPhotoCell {
    func setupUI() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false
        contentView.backgroundColor = .systemBackground

        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.12).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 1.5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = RColors.gray30.color.cgColor
        
        photoView.layer.cornerRadius = 12
        photoView.clipsToBounds = true
    }
    
    func setupLayout() {
        contentView.addSubview(photoView)
        
        photoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(421)
        }
        
        photoView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.edges.equalTo(photoView)
        }
        
        contentView.addSubview(buttonContainer)
        
        buttonContainer.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
}

extension RandomPhotoCell {
    func configure(
        imageURL: String?,
        onCancel: @escaping () -> Void
    ) {
        buttonContainer.didTapCancelButton = onCancel
        guard let imageURL = imageURL,
              let url = URL(string: imageURL) else { return }
        
        configurePhotoImageView(url: url)
    }
    
    func configurePhotoImageView(url: URL) {
        photoImageView.kf.indicatorType = .activity
        if let indicator = photoImageView.kf.indicator?.view as? UIActivityIndicatorView {
            indicator.color = .white
            indicator.style = .medium
        }
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.clipsToBounds = true
        
        let processor = DownsamplingImageProcessor(
            size: CGSize(width: photoView.bounds.width, height: 421)
        )
        
        photoImageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .transition(.fade(0.3)),
                .scaleFactor(UIScreen.main.scale),
                .cacheSerializer(FormatIndicatedCacheSerializer.jpeg)
            ]
        ) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.lastPathComponent ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
