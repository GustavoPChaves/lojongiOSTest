//
//  ViewController.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import UIKit
import SpriteKit

class FundamentalsViewController: UIViewController {

    var skView: SKView!
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = FundamentalsGameController(viewController: self)
        view.addSubview(skView)
        
        setupNavigationBar()
        
        setupConstraints()
    }
    
    func setupNavigationBar(){
        self.title = "FUNDAMENTOS"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Asap-Bold", size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.46, green: 0.79, blue: 0.53, alpha: 1)
        
        leftButton = UIButton.makeButton(imageNamed: "backButton", target: self, action: #selector(self.backButtonPressed))
        rightButton = UIButton.makeButton(imageNamed: "info", target: self, action: #selector(self.infoButtonPressed))
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: rightButton)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: leftButton)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func infoButtonPressed(){
        
    }
    
    func setupConstraints(){
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        rightButton.setupConstraints(size: 30)
        leftButton.setupConstraints(size: 30)
    }

}

