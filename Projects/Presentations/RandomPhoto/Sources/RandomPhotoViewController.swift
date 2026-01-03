//
//  RandomPhotoViewController.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import SnapKit

final class RandomPhotoViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Random Photo~"
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
