//
//  GroundClass.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import SpriteKit

class GroundClass: SKSpriteNode{
    
    func initializeGroundAndFloor(){
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = ColliderType.GROUND
        physicsBody?.isDynamic = false
    }
    
    func moveGroundsOrFloors(camera: SKCameraNode){
        if self.position.x + self.size.width <= camera.position.x{
            self.position.x += self.size.width * 3
        }
    }
}
