//
//  testt.swift
//  FlippyVerse
//
//  Created by Jeet Trivedi on 2017-05-23.
//  Copyright © 2017 Jeet Trivedi. All rights reserved.
//
//
//import UIKit
//import GoogleMobileAds
//
//class viewController: UIViewController {
//    
//    @IBOutlet weak var bannerView: GADBannerView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        bannerView.adUnitID = "ca-app-pub-5973810555125553"
//        bannerView.rootViewController = self
//        bannerView.load(request)
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    func loadRequest() {
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        bannerView.load(request)
//        
//    }
//    
//    func initializeBanner() {
//        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
//        bannerView.adUnitID = "ca-app-pub-5973810555125553"
//        bannerView.rootViewController = viewController
//        view!.addSubview(bannerView)
//    }
//    
//    
//}
