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
    }
    
    

}

