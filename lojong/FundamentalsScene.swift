//
//  Fundamentals.swift
//  lojong
//
//  Created by Gustavo Chaves on 03/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import Foundation
import SpriteKit

class FundamentalsScene: SKView, UIGestureRecognizerDelegate{
    var fundamentalsScene: SKScene!
    var camera: SKCameraNode!
    var aspectRatio: CGFloat!
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var cameraLimiter = CGPoint(x: 0, y: 0)
    
    override func didMoveToSuperview() {
        setupScene()
        addPanGesture()
        print(cameraLimiter)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(tap:)))
         self.superview?.addGestureRecognizer(tap)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene(){
        fundamentalsScene = SKScene(fileNamed: "Fundamentals")
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
        self.presentScene(fundamentalsScene)
    }
    
    func setupDays(){
        let daysNode = fundamentalsScene.childNode(withName: "Text")
        
        for (index, day) in daysNode!.children.enumerated() {
            let day = day as! SKLabelNode
            day.text = "Dia \(index+1)"
        }
    }
    
    let panGesture = UIPanGestureRecognizer()
    var previousPoint = CGPoint.zero
    
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
            let cameraInercia = SKAction.move(by: CGVector(dx: 0, dy: sender.velocity(in: self.superview).y / 5), duration: 1)
            cameraInercia.timingMode = .easeOut
            camera.run(cameraInercia)
        }
    }

        @objc func tapped(tap : UITapGestureRecognizer) {
            let viewLocation = tap.location(in: tap.view)
            let location = fundamentalsScene.convertPoint(fromView: viewLocation)
            let nodes = fundamentalsScene.nodes(at: location)
            
            print(nodes)

    //        if node[0].name == "lvlButton" {
    //            var button = node as! SKButton
    //            button.touchBegan(location)
    //        }
        }
    
}
