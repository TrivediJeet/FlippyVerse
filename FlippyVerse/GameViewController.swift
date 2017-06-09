//
//  GameViewController.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds
import GameKit

class GameViewController: UIViewController, GADInterstitialDelegate, GKGameCenterControllerDelegate {
    @IBOutlet weak var bg: UIImageView!
    
    private var gameplaycount = 0
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAd), name: NSNotification.Name(rawValue: "showAd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.incrementgameplaycount), name: NSNotification.Name(rawValue:"incrementgameplaycount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkgameplaycount), name: NSNotification.Name(rawValue:"checkgameplaycount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.openGameCenter), name: NSNotification.Name(rawValue:"openGameCenter"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showAd), name: NSNotification.Name(rawValue: "showAd"), object: nil)

        let defaults = UserDefaults.standard
        if defaults.object(forKey: "HighScore") == nil {
            defaults.set(0, forKey: "HighScore")
        } else {
            print(defaults.object(forKey: "HighScore") ?? "unknown")
        }
        
        authPlayer()
        
        
        if let view = self.view as! SKView?{
            if let scene = MainMenuSceneClass(fileNamed: "MainMenuScene"){
                scene.scaleMode = SKSceneScaleMode.aspectFit
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                view.presentScene(scene)
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone ||  UIDevice.current.userInterfaceIdiom == .pad {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func showAd() {        
        if interstitial!.isReady {
        interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
    }
    
    override func viewWillLayoutSubviews() {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            
        }

    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-5973810555125553/3653591723")
        interstitial.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
        return interstitial
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func incrementgameplaycount(){
        gameplaycount += 1
        print("Current Gameplaycount: \(gameplaycount)")
    }
    
    func checkgameplaycount() {
        if gameplaycount % 3 == 0 {
            showAd()
        }
    }
    
    func authPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            } else {
                print(GKLocalPlayer.localPlayer().isAuthenticated)
            }
        }
    }
    
    func saveHighscore(number: Int) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "FlippyVerse_Leaderboard")
            scoreReporter.value = Int64(number)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    func openGameCenter() {
        let VC = self.view.window?.rootViewController
        let GCVC = GKGameCenterViewController()
        GCVC.gameCenterDelegate = self
        VC?.present(GCVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

