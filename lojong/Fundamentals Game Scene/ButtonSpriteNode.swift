//
//  CustomButton.swift
//  lojong
//
//  Created by Gustavo Chaves on 04/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import SpriteKit

class ButtonSpriteNode: SKSpriteNode{
    var type: String!
    var state: String!
    var orientation: String!
    var day: Int!
    var delegate: ControlDaysDelegate?
    
    let tileSet = SKTileSet(named: "Forest Tile Set")
    var row: Int!
    var column: Int!
    
    var playTile: SKTileGroup!
    var lockedTile: SKTileGroup!
    var repeatTile: SKTileGroup!

    init(position: CGPoint) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 100, height: 100))
        self.position = position
        self.isUserInteractionEnabled = true
    }
    
    func setup(type: String, state: String, orientation: String, day: Int, row: Int, column: Int){
        self.type = type
        self.state = state
        self.orientation = orientation
        self.day = day
        self.row = row
        self.column = column
        
        setupTiles()
    }
    
    func setupTiles(){
        playTile = tileSet?.tileGroups.first(where: {$0.name == "\(orientation!) play \(type!)"})
        lockedTile = tileSet?.tileGroups.first(where: {$0.name == "\(orientation!) locked \(type!)"})
        repeatTile = tileSet?.tileGroups.first(where: {$0.name == "\(orientation!) repeat \(type!)"})
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == "play" {
            state = "repeat"
            delegate?.presentView(day: day,completion: {
                self.delegate?.unlock(index: self.day)
                self.delegate?.changeTile(row: self.row, column: self.column, sprite: self.repeatTile)
            })
        }
        else if state == "repeat" {
            delegate?.presentView(day: day,completion: nil)
        }
    }
    
    func unlock(){
        state = "play"
        delegate?.changeTile(row: row, column: column, sprite: playTile)
    }
}
