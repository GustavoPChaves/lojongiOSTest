//
//  ControlDaysDelegate.swift
//  lojong
//
//  Created by Gustavo Chaves on 05/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import SpriteKit

protocol ControlDaysDelegate{
    func unlock(index: Int)
    func changeTile(row: Int, column: Int, sprite: SKTileGroup)
    func presentView(completion: (()->())?)
}
