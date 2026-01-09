//
//  RandomPhotoBottomStackView.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/8/26
//

import UIKit
import DesignSystem
import RxRelay

final class RandomPhotoBottomStackView: UIStackView {
    var didTapCancelButton: (() -> Void)? // closure로 넘기는 방법 연습
    let bookmarkRelay = PublishRelay<Void>() // Relay로 변환하여 외부로 노출하는 방법 연습
    
    private lazy var cancelButton: CircleImageButton = .init(
        image: RImages.icCancel.image,
        imageColor: RColors.gray60.color,
        imageSize: 36,
        padding: NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        ),
        fillColor: .clear,
        hasStroke: true,
        action: { [weak self] in
            guard let self = self else { return }
            self.didTapCancelButton?()
        }
    )
    
    private lazy var bookmarkButton: CircleImageButton = .init(
        image: RImages.icBookmark.image,
        imageColor: .white,
        imageSize: 32,
        padding: NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        ),
        fillColor: RColors.brandColor.color,
        hasStroke: false,
        action: { [weak self] in
            guard let self = self else { return }
            self.bookmarkRelay.accept(())
        }
    )
    
    lazy var infoButton: CircleImageButton = .init(
        image: RImages.icInformation.image,
        imageColor: RColors.gray60.color,
        imageSize: 36,
        padding: NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        ),
        fillColor: .clear,
        hasStroke: true
    )
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RandomPhotoBottomStackView {
    func setupUI() {
        self.axis = .horizontal
        self.spacing = 32
        self.alignment = .center
    }
    
    func setupLayout() {
        self.addArrangedSubview(cancelButton)
        self.addArrangedSubview(bookmarkButton)
        self.addArrangedSubview(infoButton)
    }
}
