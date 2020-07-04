//
//  CustomButton.swift
//  lojong
//
//  Created by Gustavo Chaves on 04/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import SpriteKit

class CustomButton: SKSpriteNode{
    var type: String!
    var state: String!
    var orientation: String!
    var day: Int!
    init(position: CGPoint) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 100, height: 100))
        self.position = position
        self.isUserInteractionEnabled = true
    }
    
    func setup(type: String, state: String, orientation: String, day: Int){
        self.type = type
        self.state = state
        self.orientation = orientation
        self.day = day
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("state:\(state), orientation:\(orientation), type:\(type), day:\(day)")
    }
}
