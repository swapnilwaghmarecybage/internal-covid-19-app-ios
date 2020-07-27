//
//  ReachabilityManager.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/27/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import ReachabilitySwift



class ReachabilityManager {
    
    static  let shared = ReachabilityManager()
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    let reachability = Reachability()!
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        if let reachability = notification.object as? Reachability, reachability.currentReachabilityStatus != .notReachable{
            print("Network reachable  ")
            NotificationCenter.default.post(Notification(name: NetworkReceivedNotification))
        } else {
            print("Network became unreachable")
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}



