//
//  GameScene.swift
//  testwalk1031
//
//  Created by Betty on 2018/10/31.
//  Copyright © 2018 Betty. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var bear = SKSpriteNode()
    private var bearWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = .blue
        buildBear()
        //animateBear()
    }
    
    //Set up the texture atlas
    func buildBear(){
        let bearAnimatedAtlas = SKTextureAtlas(named:"BearImages")
        //walkFrames will store a texture for each frame of the bear animation
        var walkFrames:[SKTexture] = []
        let numImages = bearAnimatedAtlas.textureNames.count
        for i in 1...numImages{
            let bearTextureName = "bear\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        bearWalkingFrames = walkFrames
        
        let firstFrameTexture = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrameTexture)
        bear.position = CGPoint(x:frame.midX, y:frame.midY)
        addChild(bear)
    }
    //Let animation to run with a 0.1 second waut-time for each frame
    func animateBear(){
        bear.run(SKAction.repeatForever(
            SKAction.animate(with: bearWalkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
            withKey:"walkingInPlaceBear")
        /*"walkingInPlaceBear"if call the method again to restart the animation,
           it will simply replace the existing animation rather than create a new one*/
    }
    
    func moveBear(location: CGPoint){
        var multiplierForDirection: CGFloat
        
        let bearSpeed = frame.size.width / 3.0
        
        let moveDifference = CGPoint(x: location.x - bear.position.x, y:location.y - bear.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        
        let moveDuration = distanceToMove / bearSpeed
        
        if moveDifference.x < 0{
            multiplierForDirection = 1.0
        }
        else{
            multiplierForDirection = -1.0
        }
        bear.xScale = abs(bear.xScale) * multiplierForDirection
        
        if bear.action(forKey: "walkingInPlaceBear") == nil{
            //If legs are not moving,start them
            animateBear()
        }
        //A move action specifying where to move and how long it shoild take
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        //A done action that will run a block to stop the animation
        let doneAction = SKAction.run({ [weak self] in
            self?.bearMoveEnded()
        })
        //Combine these two actions
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        bear.run(moveActionWithDone, withKey:"bearMoving")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        /*var multiplierForDirection: CGFloat
        if location.x < frame.midX{
            //walk left
            multiplierForDirection = 1.0
        }
        else{
            //walk right
            multiplierForDirection = -1.0
        }
        
        bear.xScale = abs(bear.xScale) * multiplierForDirection
        animateBear()*/
        
        moveBear(location:location)
        
        
    }
    //Remove all actions and stop the animation
    func bearMoveEnded(){
        bear.removeAllActions()
    }
}

