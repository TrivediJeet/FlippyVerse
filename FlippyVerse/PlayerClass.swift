//
//  PlayerClass.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import SpriteKit

struct ColliderType{
    static let PLAYER: UInt32 = 0
    static let GROUND: UInt32 = 1
    static let ROCKET_AND_COLLECTABLES: UInt32 = 2
}

class Player: SKSpriteNode{
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initializePlayer(){
        name = "Player"
        
        for i in 1...9{
            let name = "bot0\(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        self.run(SKAction.repeatForever(animatePlayerAction))
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = ColliderType.ROCKET_AND_COLLECTABLES
    }
    
    func move(distance: Int){
        if distance < 500 {
            self.position.x += 10
        } else if distance < 1000 {
            self.position.x += 15
        } else if distance < 1000 {
            self.position.x += 15
        } else if distance < 1000 {
            self.position.x += 15
        } else if distance < 1000 {
            self.position.x += 15
        } else {
            self.position.x += 20
        }
    }
    
    func reversePlayer(){
        self.run(SKAction.scaleY(to: self.yScale * -1, duration: 0.1))
    }
    
}
