//
//  RandomPhotoViewController.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import SnapKit
import ReactorKit

final class RandomPhotoViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Random Photo~"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func bind(reactor: RandomPhotoReactor) {
        
    }
}

private extension RandomPhotoViewController {
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
