//
//  ViewController.swift
//  CacheExample
//
//  Created by 山本響 on 2022/03/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func didTapButton() {
        let vc = SecondVC()
        present(vc, animated: true)
    }
}



