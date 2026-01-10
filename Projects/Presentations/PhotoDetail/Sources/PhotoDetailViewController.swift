//
//  PhotoDetailViewController.swift
//  PhotoDetail
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import SnapKit
import ReactorKit

final class PhotoDetailViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    init(reactor: PhotoDetailReactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        print("⭕ PhotoDetailViewController init!")
    }
    
    deinit {
        print("❎ PhotoDetailViewController deinit!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello~"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }

    func bind(reactor: PhotoDetailReactor) {
        
    }
}

private extension PhotoDetailViewController {
    func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
    
    func setupLayout() {
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
