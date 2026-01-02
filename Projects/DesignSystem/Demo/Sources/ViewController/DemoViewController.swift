//
//  DemoViewController.swift
//  DesignSystemDemo
//
//  Created by 김동준 on 12/30/25
//

import UIKit
import SnapKit
import DesignSystem

class DemoViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        return label
    }()
    
    private let navigationBar = RNavigationBar(style: .logo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
}

extension DemoViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        view.addSubview(label)
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
        }
    }
}
