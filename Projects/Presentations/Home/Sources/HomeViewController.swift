//
//  HomeViewController.swift
//  Home
//
//  Created by 김동준 on 12/31/25
//

import UIKit
import SnapKit
import ReactorKit

final class HomeViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello~"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func bind(reactor: HomeReactor) {
        
    }
}

private extension HomeViewController {
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
