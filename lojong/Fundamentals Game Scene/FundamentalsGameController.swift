//
//  Fundamentals.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation
import SpriteKit

class FundamentalsGameController: SKView{
    
    var viewController: UIViewController!
    var fundamentalsScene: SKScene!
    var map: SKTileMapNode!
    var elephant: SKSpriteNode!
    var camera: SKCameraNode!
    var restPositions: SKNode!
    var aspectRatio: CGFloat!
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    var previousPoint = CGPoint.zero
    var currentPosition: Int = 0
    var buttons: [ButtonSpriteNode] = []
    let panGesture = UIPanGestureRecognizer()
    
    override func didMoveToSuperview() {
        viewHeight = self.frame.height
        viewWidth = self.frame.width
        aspectRatio = 1.3 * viewWidth / viewHeight
        
        setupScene()
        addPanGesture()
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
    
    //MARK: Scene Setup
    func setupScene(){
        fundamentalsScene = SKScene(fileNamed: "Fundamentals")
        map = fundamentalsScene.childNode(withName: "Tile Map Node") as? SKTileMapNode
        restPositions = fundamentalsScene.childNode(withName: "restPositions")
        
        setupCamera()
        setupButtonsAndLabelsForDays()
        setupPlayer()
        
        fundamentalsScene.scaleMode = .aspectFill
        self.presentScene(fundamentalsScene)
    }
    func setupPlayer(){
        elephant = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "elephant")))
        fundamentalsScene.addChild(elephant)
        elephant.position = restPositions.children[currentPosition].position
    }
    func setupCamera(){
        var cameraLimiter = CGPoint(x: 0, y: 0)
        cameraLimiter.x = viewHeight * aspectRatio
        cameraLimiter.y = fundamentalsScene.childNode(withName: "End")!.position.y - viewHeight * aspectRatio
        
        camera = fundamentalsScene.camera
        camera.position = CGPoint(x: 0, y: cameraLimiter.x)
        let constraint = SKConstraint.positionY(SKRange(lowerLimit: cameraLimiter.x, upperLimit: cameraLimiter.y))
        camera.constraints = [constraint]
    }
    
    func setupButtonsAndLabelsForDays(){
        let daysNode = fundamentalsScene.childNode(withName: "Text")
        
        for (index, day) in daysNode!.children.enumerated() {
            let day = day as! SKLabelNode
            day.text = "Dia \(index+1)"
            day.fontName = "Asap-Medium"
            
            setupButtons(position: day.position, index: index)
        }
    }
    
    func setupButtons(position: CGPoint, index: Int){
        let buttonNode = ButtonSpriteNode(position: position + CGPoint(x: 0, y: 25))
        buttonNode.delegate = self
        buttons.append(buttonNode)
        fundamentalsScene.addChild(buttonNode)
        
        let location = position
        let column = map.tileColumnIndex(fromPosition: location)
        let row = map.tileRowIndex(fromPosition: location)
        let tile = map.tileDefinition(atColumn: column, row: row)
        
        let state = tile!.userData?.value(forKey: "state") as! String
        let orientation = tile!.userData?.value(forKey: "orientation") as! String
        let type = tile!.userData?.value(forKey: "type") as! String
        
        buttonNode.setup(type: type, state: state, orientation: orientation, day: index + 1, row: row, column: column)
    }
    
    //MARK: PanGesture
    func  addPanGesture()
    {
        self.panGesture.addTarget(self, action: #selector(pannedView(_:) ))
        self.panGesture.delegate = self as UIGestureRecognizerDelegate
        self.superview?.addGestureRecognizer(self.panGesture)
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
    
    func movePlayer(){
        let node = restPositions.children[currentPosition]
        elephant.position = node.position
        
        if node.userData?.value(forKey: "type") as! String == "floor"{
            elephant.texture = SKTexture(image: #imageLiteral(resourceName: "elephant"))
        }
        else if node.userData?.value(forKey: "type") as! String == "water"{
            elephant.texture = SKTexture(image: #imageLiteral(resourceName: "elephantBoat"))
        }
    }
}
extension FundamentalsGameController: UIGestureRecognizerDelegate{
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        camera.removeAllActions()
        self.previousPoint = self.camera.position
        return true
    }
}
extension FundamentalsGameController: ControlDaysDelegate{
    func unlock(index: Int){
        if index < buttons.count{
            buttons[index].unlock()
            currentPosition = index
            
            movePlayer()
        }
        else{
            elephant.isHidden = true
        }
    }
    
    func changeTile(row: Int, column: Int, sprite: SKTileGroup) {
        map.setTileGroup(sprite, forColumn: column, row: row)
    }
    
    func presentView(day: Int, completion: (()->())? = nil){
        let newViewController = DayMeditationViewController()
        newViewController.day = day
        newViewController.modalPresentationStyle = .custom
        viewController.show(newViewController, sender: true)
        completion?()
    }
}
