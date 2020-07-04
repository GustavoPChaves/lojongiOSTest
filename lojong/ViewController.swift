//
//  ViewController.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    
    var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        skView = FundamentalsScene(viewController: self)
        view.addSubview(skView)
        setupConstraints()
    }
    
    func setupConstraints(){
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    

}

