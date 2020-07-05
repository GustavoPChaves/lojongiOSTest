//
//  DayMeditationViewController.swift
//  lojong
//
//  Created by Gustavo Chaves on 04/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import UIKit

class DayMeditationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "FUNDAMENTOS"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Asap-Bold", size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let button = makeBackButton()
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: button)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // = CGRect(x: 0, y: 0, width: 63, height: 63)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 63, height: 63)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        
        
        return backButton
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}
