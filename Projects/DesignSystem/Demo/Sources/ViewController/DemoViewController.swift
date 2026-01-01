//
//  DemoViewController.swift
//  DesignSystemDemo
//
//  Created by 김동준 on 12/30/25
//

import UIKit
import SnapKit

class DemoViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        return label
    }()
    
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
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
