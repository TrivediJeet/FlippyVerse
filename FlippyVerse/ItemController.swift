//
//  ItemController.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import SpriteKit

class ItemController {
    
    private var textureAtlas = SKTextureAtlas()
    private var missleAnimation = [SKTexture]()
    private var coinAnimation = [SKTexture]()
    private var animateMissileAction = SKAction()
    private var animateCoinRotation = SKAction()
    
    private var minY = CGFloat(-263), maxY = CGFloat(263)
    
    var item: SKSpriteNode?
    
    func spawnRocket(camera: SKCameraNode) -> SKSpriteNode {
        
        for i in 1...3{
            let name = "missile\(i)"
            missleAnimation.append(SKTexture(imageNamed: name))
        }
        animateMissileAction = SKAction.animate(with: missleAnimation, timePerFrame: 0.002, resize: true, restore: false)
        item = SKSpriteNode(imageNamed: "missile1")
        item?.name = "Rocket"
        item?.setScale(0.2)
        item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        item?.physicsBody?.affectedByGravity = false
        item?.physicsBody?.categoryBitMask = ColliderType.ROCKET_AND_COLLECTABLES
        item?.physicsBody?.collisionBitMask = ColliderType.PLAYER
        item?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        item?.zPosition = 5
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item?.position.x = camera.position.x + 900
        item?.position.y = randomBetweenNumbers(firstNum: minY, secondNum: maxY)
        item?.run(SKAction.repeatForever(animateMissileAction))
        
        return item!
    }
    
    func spawnCoin (camera: SKCameraNode) -> SKSpriteNode {
        
        for i in 1...12 {
            let name = "coin\(i)"
            coinAnimation.append(SKTexture(imageNamed: name))
        }
        animateCoinRotation = SKAction.animate(with: coinAnimation, timePerFrame: 0.1)
        
        item = SKSpriteNode(imageNamed: "Coin")
        item?.name = "Coin"
        item?.setScale(0.7)
        item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        item!.physicsBody?.affectedByGravity = false
        item?.physicsBody?.categoryBitMask = ColliderType.ROCKET_AND_COLLECTABLES
        item?.physicsBody?.collisionBitMask = ColliderType.PLAYER
        item?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        item?.zPosition = 5
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item?.position.x = camera.position.x + 900
        item?.position.y = randomBetweenNumbers(firstNum: minY, secondNum: maxY)
        item?.run(SKAction.repeatForever(animateCoinRotation))
        
        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum:CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum,secondNum)
    }
    
}
