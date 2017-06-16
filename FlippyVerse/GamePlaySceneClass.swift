//
//  GamePlaySceneClass.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SpriteKit
import AVFoundation
import GameKit

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    private var mainCamera: SKCameraNode?
    let defaults = UserDefaults.standard
    var audioPlayer = AVAudioPlayer()
    private var score = 0
    private var distance = 0
    private var clickicon: SKNode?
    private var player: Player?
    private var scoreLabel: SKLabelNode?
    private var distanceLabel: SKLabelNode?

    private var itemController = ItemController()
    
    private var bg1: BGClass?
    private var bg2: BGClass?
    private var bg3: BGClass?
    private var bg4: BGClass?
    private var bg5: BGClass?
    private var bg6: BGClass?
    private var bg7: BGClass?
    private var bg8: BGClass?
    private var bg9: BGClass?
    
    private var ground1: GroundClass?
    private var ground2: GroundClass?
    private var ground3: GroundClass?
    private var ground4: GroundClass?
    private var ground5: GroundClass?
    private var ground6: GroundClass?

    
    private var roof1: GroundClass?
    private var roof2: GroundClass?
    private var roof3: GroundClass?
    private var roof4: GroundClass?
    private var roof5: GroundClass?
    private var roof6: GroundClass?

    override func didMove(to view: SKView) {
        initializeGame()
    }

    private func initializeGame(){
        
        physicsWorld.contactDelegate = self
        
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode
        
        clickicon = mainCamera?.childNode(withName: "ClickIcon")
        initializeclickanimation(clickicon: clickicon!)
        
        player = childNode(withName: "Player") as? Player
        player?.initializePlayer()
        
        scoreLabel = mainCamera?.childNode(withName: "ScoreLabel") as? SKLabelNode
        scoreLabel?.text = "0"
        
        distanceLabel = mainCamera?.childNode(withName: "DistanceLabel") as? SKLabelNode
        distanceLabel?.text = "0m"
        
        bg1 = childNode(withName: "BG1") as? BGClass
        bg2 = childNode(withName: "BG2") as? BGClass
        bg3 = childNode(withName: "BG3") as? BGClass
        bg4 = childNode(withName: "BG4") as? BGClass
        bg5 = childNode(withName: "BG5") as? BGClass
        bg6 = childNode(withName: "BG6") as? BGClass
        bg7 = childNode(withName: "BG7") as? BGClass
        bg8 = childNode(withName: "BG8") as? BGClass
        bg9 = childNode(withName: "BG9") as? BGClass

        ground1 = childNode(withName: "Ground1") as? GroundClass!
        ground2 = childNode(withName: "Ground2") as? GroundClass!
        ground3 = childNode(withName: "Ground3") as? GroundClass!
        ground4 = childNode(withName: "Ground4") as? GroundClass!
        ground5 = childNode(withName: "Ground5") as? GroundClass!
        ground6 = childNode(withName: "Ground6") as? GroundClass!
        ground1?.initializeGroundAndFloor()
        ground2?.initializeGroundAndFloor()
        ground3?.initializeGroundAndFloor()
        ground4?.initializeGroundAndFloor()
        ground5?.initializeGroundAndFloor()
        ground6?.initializeGroundAndFloor()
        
        roof1 = childNode(withName: "Roof1") as? GroundClass!
        roof2 = childNode(withName: "Roof2") as? GroundClass!
        roof3 = childNode(withName: "Roof3") as? GroundClass!
        roof4 = childNode(withName: "Roof4") as? GroundClass!
        roof5 = childNode(withName: "Roof5") as? GroundClass!
        roof6 = childNode(withName: "Roof6") as? GroundClass!
        roof1?.initializeGroundAndFloor()
        roof2?.initializeGroundAndFloor()
        roof3?.initializeGroundAndFloor()
        roof4?.initializeGroundAndFloor()
        roof5?.initializeGroundAndFloor()
        roof6?.initializeGroundAndFloor()
        
        Timer.scheduledTimer(timeInterval: TimeInterval(6), target: self, selector: #selector(GameplaySceneClass.spawnRockets), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(1.5), target: self, selector: #selector(GameplaySceneClass.spawnCoins), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(GameplaySceneClass.removeItems), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageCamera()
        manageBGsAndGrounds()
        player?.move(distance: distance)
        moveRocket()
        distance += 1
        distanceLabel?.text = "\(distance)m"
        
    }
    
    private func manageCamera(){
        
        if distance < 500 {
            self.mainCamera?.position.x += 10
        } else if distance < 1000 {
            self.mainCamera?.position.x += 12
        } else if distance < 1500 {
            self.mainCamera?.position.x += 14
        } else if distance < 2000 {
            self.mainCamera?.position.x += 16
        } else if distance < 2500 {
            self.mainCamera?.position.x += 18
        } else {
            self.mainCamera?.position.x += 20
        }
    }
    
    private func manageBGsAndGrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
        bg4?.moveBG(camera: mainCamera!)
        bg5?.moveBG(camera: mainCamera!)
        bg6?.moveBG(camera: mainCamera!)

        ground1?.moveGroundsOrFloors(camera: mainCamera!)
        ground2?.moveGroundsOrFloors(camera: mainCamera!)
        ground3?.moveGroundsOrFloors(camera: mainCamera!)
        ground4?.moveGroundsOrFloors(camera: mainCamera!)
        ground5?.moveGroundsOrFloors(camera: mainCamera!)
        ground6?.moveGroundsOrFloors(camera: mainCamera!)
        
        roof1?.moveGroundsOrFloors(camera: mainCamera!)
        roof2?.moveGroundsOrFloors(camera: mainCamera!)
        roof3?.moveGroundsOrFloors(camera: mainCamera!)
        roof4?.moveGroundsOrFloors(camera: mainCamera!)
        roof5?.moveGroundsOrFloors(camera: mainCamera!)
        roof6?.moveGroundsOrFloors(camera: mainCamera!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickicon?.removeFromParent()
        self.run(SKAction.playSoundFileNamed("jump.wav", waitForCompletion: true))
        reverseGravity()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
    
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            score += 1
            self.run(SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true))
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Rocket" {
            self.run(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: true))            
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            let highScore = defaults.integer(forKey: "HighScore")
            if score > highScore {
                defaults.set(score, forKey: "HighScore")
                saveHighscore(number: score)
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
        }
    }
    

    private func reverseGravity() {
        physicsWorld.gravity.dy *= (-1)
        player?.reversePlayer()
    }
    
    func spawnRockets(){
        self.scene?.addChild(itemController.spawnRocket(camera: mainCamera!))
    }
    func spawnCoins(){
        self.scene?.addChild(itemController.spawnCoin(camera: mainCamera!))
    }
    
    func restartGame() {
        if let view = self.view {
            if let scene = MainMenuSceneClass(fileNamed: "MainMenuScene"){
                scene.scaleMode = SKSceneScaleMode.aspectFit
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                self.removeAllChildren()
                self.removeFromParent()
                view.presentScene(scene)
            }
        }
    }
    
    private func moveRocket() {
        enumerateChildNodes(withName: "Rocket", using: ({
            (node, error) in
            node.position.x -= 4
        }))
    }
    
    func removeItems() {
        for child in children {
            if child.name == "Coin" || child.name == "Rocket" {
                if child.position.x < self.mainCamera!.position.x - self.scene!.frame.width / 2 {
                    child.removeFromParent()
                }
            }
        }
    }
    
    func initializeclickanimation(clickicon: SKNode){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"incrementgameplaycount"), object: nil)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let pulse = SKAction.sequence([fadeOut, fadeIn])
        let pulseForever = SKAction.repeatForever(pulse)
        clickicon.run(pulseForever)
    }
    
    func saveHighscore(number: Int) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "FlippyVerse_Leaderboard")
            scoreReporter.value = Int64(number)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
}

