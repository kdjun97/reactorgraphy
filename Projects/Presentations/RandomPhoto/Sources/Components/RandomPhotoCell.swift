//
//  RandomPhotoCell.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/7/26
//

import UIKit
import DesignSystem
import RxSwift

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
    }
    
    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
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
    }
    
    func setupLayout() {
        contentView.addSubview(photoView)
        
        photoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(421)
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
        onCancel: @escaping () -> Void
    ) {
        buttonContainer.didTapCancelButton = onCancel
    }
}
