//
//  DayMeditationViewController.swift
//  lojong
//
//  Created by Gustavo Chaves on 04/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import UIKit

class DayMeditationViewController: UIViewController {

    var day = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        
        print(day)
    }
    
    func setupNavigationBar(){
        self.title = "FUNDAMENTOS"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Asap-Bold", size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let leftButton = UIButton.makeButton(imageNamed: "backButton", target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: leftButton)
        leftButton.setupConstraints(size: 30)
    }

    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}
