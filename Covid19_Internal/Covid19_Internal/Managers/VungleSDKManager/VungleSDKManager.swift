//
//  VungleSDKManager.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghmare on 22/09/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class VungleSDKManager: NSObject {
    
    private let appID = "5d013b549a86cb541f181a4d" //"5c003b9a3933314cf38ff7f3" //"5d013b549a86cb541f181a4d"
    private let MRECADID = "MREC-1099459"
    private let BANNERADID = "BANNER-1422635"//"BANNER3-7718044" //"BANNER-1422635"
    private let INTERSTITIALADID = "DEFAULT-9724429"
    private var counterForInterstitial = 0
    
    func initialiseVungleSDK() {
        
        let sdk:VungleSDK = VungleSDK.shared()
        sdk.delegate = self
        sdk.setLoggingEnabled(true)
         do {
            try sdk.start(withAppId: self.appID);
         }
         catch let error as NSError {
             print("Error while starting VungleSDK : \(error.domain)")
         return;
         }
    }
    
    func showMRECAd(mrecViewArea: UIView){
        
        let options: [AnyHashable : Any] = [:]
        do {
          try VungleSDK.shared().addAdView(to: mrecViewArea, withOptions: options, placementID: MRECADID)
        } catch  let error as NSError {
            print("Error while showing MREC Ad: \(error.domain)")
        return
        }
    }

    func isMRECAdAvailable() -> Bool  {
       return VungleSDK.shared().isAdCached(forPlacementID: MRECADID)
    }

    
    func showBanner(bannerView: UIView) {
        let options: [AnyHashable : Any] = [:]
        do {
          try VungleSDK.shared().addAdView(to: bannerView, withOptions: options, placementID: BANNERADID)
        } catch  let error as NSError {
            print("Error while showing MREC Ad: \(error.domain)")
        return
        }
    }
    
    func loadBanner(){
        do {
            try VungleSDK.shared().loadPlacement(withID: BANNERADID, with: VungleAdSize.banner)

        } catch let error as NSError {
            print("Error encountered Loading Banner: + \(error)");
               self.loadInterstitialAd()
           }
    }
    
    func isBanneAvailable() -> Bool {
        return VungleSDK.shared().isAdCached(forPlacementID: BANNERADID)
    }
    
    func  incermentCounterForInterstitial() {
        counterForInterstitial += 1
    }
    
    func showInterstitial(controller: UIViewController){
        if(counterForInterstitial > 3){
            counterForInterstitial = 0
            do {
             try VungleSDK.shared().playAd(controller, options: nil, placementID: INTERSTITIALADID)
            }
            catch let error as NSError {
             print("Error encountered playing ad: + \(error)");
                self.loadInterstitialAd()
            }
        }
        return
    }
    
    
    func isInterstitialCached() -> Bool {
        return VungleSDK.shared().isAdCached(forPlacementID: INTERSTITIALADID)
    }
    
    // not needed for autocached ads
    func loadInterstitialAd() {
        do {
            try VungleSDK.shared().loadPlacement(withID: INTERSTITIALADID)
        }
        catch let error as NSError {
            print("Unable to load placement with reference ID :\(INTERSTITIALADID), Error: \(error)")
        return
        }
    }
    
}

extension VungleSDKManager: VungleSDKDelegate {
    
    func vungleSDKDidInitialize() {
        print("SDK successfully initialized")
        loadBanner()
    }
    
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?, error: Error?) {
        print("AdAvailable: \(isAdPlayable) PlacementID: \(placementID ?? "")")
    }
    
    
}
