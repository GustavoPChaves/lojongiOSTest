//
//  Fundamentals.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation
import SpriteKit

class FundamentalsScene: SKView, UIGestureRecognizerDelegate, ControlDaysDelegate{
    
    func changeTile(row: Int, column: Int, sprite: SKTileGroup) {
        map.setTileGroup(sprite, forColumn: column, row: row)
    }
    
    func presentView(){
        
//        let newViewController = DayMeditationViewController()
//        newViewController.modalPresentationStyle = .automatic
//        //viewController.navigationController?.pushViewController(newViewController, animated: true)
//        viewController.present(newViewController, animated: true, completion: nil)
    }
    
    var viewController: UIViewController!
    var fundamentalsScene: SKScene!
    var camera: SKCameraNode!
    var aspectRatio: CGFloat!
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    var map: SKTileMapNode!
    var buttons: [CustomButton] = []
    
    var cameraLimiter = CGPoint(x: 0, y: 0)
    
    let panGesture = UIPanGestureRecognizer()
    var previousPoint = CGPoint.zero
    
    var restPositions: SKNode!
    var currentPosition: Int = 0
    
    var elephant: SKSpriteNode!
    
    override func didMoveToSuperview() {
        setupScene()
        addPanGesture()
        print(cameraLimiter)
        //let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(tap:)))
        //self.superview?.addGestureRecognizer(tap)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(viewController: UIViewController) {
        super.init(frame: viewController.view.frame)
        self.viewController = viewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene(){

        fundamentalsScene = SKScene(fileNamed: "Fundamentals")
        map = fundamentalsScene.childNode(withName: "Tile Map Node") as? SKTileMapNode
        restPositions = fundamentalsScene.childNode(withName: "restPositions")
        fundamentalsScene.scaleMode = .aspectFill
        viewHeight = (fundamentalsScene.frame.height)
        viewWidth = (fundamentalsScene.frame.width)
        aspectRatio = viewWidth / viewHeight
        cameraLimiter.x = viewHeight * aspectRatio
        
        cameraLimiter.y = fundamentalsScene.childNode(withName: "End")!.position.y - viewHeight * aspectRatio
        camera = fundamentalsScene.camera
        camera.position = CGPoint(x: 0, y: cameraLimiter.x)
        let constraint = SKConstraint.positionY(SKRange(lowerLimit: cameraLimiter.x, upperLimit: cameraLimiter.y))
        camera.constraints = [constraint]
        setupDays()
        
        elephant = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "elephant")))
        fundamentalsScene.addChild(elephant)
        elephant.position = restPositions.children[currentPosition].position
        
        self.presentScene(fundamentalsScene)
    }
    
    func setupDays(){
        let daysNode = fundamentalsScene.childNode(withName: "Text")
        
        for (index, day) in daysNode!.children.enumerated() {
            let day = day as! SKLabelNode
            day.text = "Dia \(index+1)"
            
            let buttonNode =  CustomButton(position: day.position + CGPoint(x: 0, y: 25))
            buttonNode.delegate = self
            buttons.append(buttonNode)
            fundamentalsScene.addChild(buttonNode)
            
            
                let location = day.position
                let column = map.tileColumnIndex(fromPosition: location)
                let row = map.tileRowIndex(fromPosition: location)
                let tile = map.tileDefinition(atColumn: column, row: row)
                
                
               let state = tile!.userData?.value(forKey: "state") as! String
               let orientation = tile!.userData?.value(forKey: "orientation") as! String
               let type = tile!.userData?.value(forKey: "type") as! String
                
            buttonNode.setup(type: type, state: state, orientation: orientation, day: index + 1, row: row, column: column)
            
        }
    }
    
    func unlock(index: Int){
        if index < buttons.count{
            
            buttons[index].unlock()
            currentPosition = index
            let node = restPositions.children[currentPosition]
            elephant.position = node.position
            
            if node.userData?.value(forKey: "type") as! String == "floor"{
                elephant.texture = SKTexture(image: #imageLiteral(resourceName: "elephant"))
            }
            else if node.userData?.value(forKey: "type") as! String == "water"{
                elephant.texture = SKTexture(image: #imageLiteral(resourceName: "elephantBoat"))
            }
        }
        else{
            elephant.isHidden = true
        }
    }
    
    func  addPanGesture()
    {
        self.panGesture.addTarget(self, action: #selector(pannedView(_:) ))
        self.panGesture.delegate = self as UIGestureRecognizerDelegate
        
        self.superview?.addGestureRecognizer(self.panGesture)
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        camera.removeAllActions()
        self.previousPoint = self.camera.position
        
        return true
    }
    
    @objc func pannedView(_ sender:UIPanGestureRecognizer)
    {
        
        let transPoint = sender.translation(in: self.superview)
        
        let newPosition = previousPoint + CGPoint(x: 0, y: transPoint.y * 1.5)
        
        self.camera.position = newPosition
        
        if sender.state == .ended {
            let cameraInercia = SKAction.move(by: CGVector(dx: 0, dy: sender.velocity(in: self.superview).y / 2), duration: 1)
            cameraInercia.timingMode = .easeOut
            camera.run(cameraInercia)
        }
    }
    
    @objc func tapped(tap : UITapGestureRecognizer) {
        let viewLocation = tap.location(in: tap.view)
        let location = fundamentalsScene.convertPoint(fromView: viewLocation)
        let nodes = fundamentalsScene.nodes(at: location)
        
    }
    
}
protocol ControlDaysDelegate{
    func unlock(index: Int)
    func changeTile(row: Int, column: Int, sprite: SKTileGroup)
    func presentView()
}
