//
//  Fundamentals.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation
import SpriteKit

class FundamentalsScene{
    var fundamentalsScene: SKScene!
    
    override func didMoveToSuperview() {
        setupScene()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene(){
        
    }
}
