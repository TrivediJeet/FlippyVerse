//
//  BGClass.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode{
    func moveBG(camera: SKCameraNode){
        if self.position.x + self.size.width <= camera.position.x{
            self.position.x += self.size.width * 3
        }
    }
}
