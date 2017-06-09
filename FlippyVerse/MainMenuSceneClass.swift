//
//  MainMenuSceneClass.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//


import SpriteKit

class MainMenuSceneClass: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var exitButton = UIButton()
    private var bg: SKSpriteNode?
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        let standards = UserDefaults.standard
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode
        scoreLabel?.text = "High Score:  \(String(describing: standards.object(forKey: "HighScore")!))"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"checkgameplaycount"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Share" {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"openGameCenter"), object: nil)
            }
            if atPoint(location).name == "Start" {
                
                if let view = self.view {
                    if let scene = GameplaySceneClass(fileNamed: "GamePlayScene") {
                        scene.scaleMode = SKSceneScaleMode.aspectFit
                        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                    }
                    if let scene = SKScene(fileNamed: "GameScene") {
                        self.removeAllChildren()
                        self.removeFromParent()
                        scene.scaleMode = .aspectFit
                        view.presentScene(scene)
                    }
                    
 
                    view.ignoresSiblingOrder = true
                    //view.showsPhysics = true
                    view.showsFPS = true
//                    view.showsNodeCount = true
                }
            }
        }
    }
    
}

extension UIButton {
    ///set Corner Radius for UIButton
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}







