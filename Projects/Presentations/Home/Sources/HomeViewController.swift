//
//  HomeViewController.swift
//  Home
//
//  Created by 김동준 on 12/31/25
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello~"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
