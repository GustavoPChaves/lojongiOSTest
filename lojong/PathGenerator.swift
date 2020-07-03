//
//  PathGenerator.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation
import SpriteKit

class PathGenerator: SKView{
    var fundamentalScene: SKScene!
    var map: SKNode!
    let columns = 128
    let rows = 128
    
    let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
    let tileSize = CGSize(width: 128, height: 128)
    
    override func didMoveToSuperview() {
        setupSKView()
        setupScene()
        map = SKNode()
        fundamentalScene.addChild(map)
        map.xScale = 0.2
        map.yScale = 0.2
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSKView(){
        self.showsFPS = true
        self.showsNodeCount = true
    }
    
    func setupScene(){
        fundamentalScene = SKScene(size:  (self.bounds.size))

        // Set the scene coordinates (0, 0) to the center of the screen.
        fundamentalScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        fundamentalScene.scaleMode = .aspectFit
        fundamentalScene.backgroundColor = SKColor.blue
        
        self.presentScene(fundamentalScene)
    }
}
