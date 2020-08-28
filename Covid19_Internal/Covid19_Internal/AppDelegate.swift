//
//  AppDelegate.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/14/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit
import CoreData
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseManager.configure()
        if let _ = UserDefaults.standard.value(forKey: USERNAME) {
            setupNotificationForApplication()
        }
        setupLaunchOptionFromNotification(launchOptions: launchOptions)
        return true
    }
    
    func setupNotificationForApplication(){
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
              
                print("@@@###@@@ Permission granted: \(granted)")
                guard granted else { return }
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    print("@@@###@@@ Notification settings: \(settings)")
                    guard settings.authorizationStatus == .authorized else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
        }
    }
    
    func setupLaunchOptionFromNotification(launchOptions:[UIApplication.LaunchOptionsKey: Any]? ){
        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]
        
        // 1
        NSLog("@@@###@@@ Method Name %@","setupLaunchOptionFromNotification")
        NSLog("@@@###@@@ setupLaunchOptionFromNotificationNotification %@ ", notificationOption.debugDescription)
        if let notification = notificationOption as? [String: AnyObject],
            let _newsId = notification["newsId"] as? String {
           
            NSLog("@@@###@@@ Method Name %@","Inside aps Section passed \(_newsId)")
            // 2
            launchFeedDetailsViewOnNotificationTap(newsId: _newsId)
            // 3

        }
    }
    
    func launchFeedDetailsViewOnNotificationTap(newsId: String){
              NSLog( "@@@###@@@ Method Name: %@",   "launchFeedDetailsViewOnNotificationTap")
        if let _ = UserDefaults.standard.value(forKey: USERNAME){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let baseTabBarController = window?.rootViewController as? BaseTabBarViewController {
                baseTabBarController.selectedIndex = 0
                if let navController = baseTabBarController.selectedViewController as? NavigationVC {
                    if let feedVC = storyboard.instantiateViewController(withIdentifier: "FeedListViewController") as? FeedListViewController,
                        let feedDetailVC = storyboard.instantiateViewController(withIdentifier: "FeedDetailViewController") as? FeedDetailViewController
                    {
                        navController.viewControllers.append(feedVC)
                        feedDetailVC.newsid = newsId
                        navController.viewControllers.append(feedDetailVC)
                    }
                    
                }
            }
        }
    }
    
    //MARK:- Notification
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        
        NSLog( "@@@###@@@ Method Name: %@",   "didReceiveRemoteNotification")
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("@@@###@@@ Message ID: \(messageID)")
            NSLog( "@@@###@@@ Message ID: %@",   "\(messageID)")
        }

        // Print full message.
        print(userInfo)
        NSLog( "@@@###@@@ userInfo: %@",   "\(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        NSLog( "@@@###@@@ Method Name: %@",   "didReceiveRemoteNotification fetchCompletionHandler")

        if let messageID = userInfo[gcmMessageIDKey] {
            print("@@@###@@@ Message ID: \(messageID)")
            NSLog( "@@@###@@@ Message ID: %@",   "\(messageID)")
        }
        // Print full message.
        print(userInfo)
        NSLog( "@@@###@@@ userInfo: %@",   "\(userInfo)")
        
        let newsIDKey = "newsId"
        NSLog( "@@@###@@@ news id1: %@",   "\(userInfo[newsIDKey] as? String ?? "")")
        /*
        if UIApplication.shared.applicationState == .inactive {
            let newsIDKey = "newsId"
            NSLog( "@@@###@@@ news id2: %@",   "\(userInfo[newsIDKey] as? String ?? "")")

            if let _newsId = userInfo[newsIDKey] as? String {
                NSLog( "@@@###@@@ news id3: %@",   "\(userInfo[newsIDKey] as? String ?? "")")
                launchFeedDetailsViewOnNotificationTap(newsId: _newsId)
            }
        }*/
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("@@@###@@@ Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("@@@###@@@ APNs token retrieved: \(deviceToken)")
        NSLog( "@@@###@@@ Method Name: %@",   "didRegisterForRemoteNotificationsWithDeviceToken")
        /*
         let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
         let token = tokenParts.joined()
         print("Device Token: \(token)")
         */
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        FirebaseManager.updateFCMToken(token: token)
         NSLog( "@@@###@@@ deviceToken: %@",   "\(deviceToken)")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Starts monitoring network reachability status changes
        ReachabilityManager.shared.startMonitoring()
    }
    func applicationWillEnterForeground(_ application: UIApplication){
        // Stops monitoring network reachability status changes
        ReachabilityManager.shared.stopMonitoring()
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Covid19_Internal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("@@@###@@@ Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension AppDelegate : MessagingDelegate {
  // [START refresh_token]
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    print("@@@###@@@ Firebase registration token: \(fcmToken)")
    NSLog("@@@###@@@ Method Name: %@", "messaging didReceiveRegistrationToken")
   
    let dataDict:[String: String] = ["token": fcmToken]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
    FirebaseManager.updateFCMToken(token: fcmToken)
    NSLog("@@@###@@@ FCM token: %@", "\(fcmToken)")

  }
  // [END refresh_token]
}


extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    NSLog( "@@@###@@@ Method Name: %@",   "userNotificationCenter center willPresent notification withCompletionHandler completionHandler")

    if let messageID = userInfo[gcmMessageIDKey] {
      print("@@@###@@@ Message ID: \(messageID)")
        NSLog( "@@@###@@@ Message ID: %@",   "\(messageID)")

    }

    // Print full message.
    print(userInfo)
   NSLog( "@@@###@@@ userInfo: %@",   "\(userInfo)")
    // Change this to your preferred presentation option
    completionHandler([[.alert]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    NSLog( "@@@###@@@ Method Name: %@",   "userNotificationCenter didReceive response withCompletionHandler completionHandler")

    // Print message ID.
    
    if let messageID = userInfo[gcmMessageIDKey] {
      print("@@@###@@@ Message ID: \(messageID)")
    NSLog( "@@@###@@@ Message ID:: %@",   "\(messageID)")
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)
    let newsIDKey = "newsId"
    NSLog( "@@@###@@@ userInfo: %@",   "\(userInfo)")
    NSLog( "@@@###@@@ gcm.notification.newsId : %@","\(userInfo[newsIDKey])")
    if let _newsId = userInfo[newsIDKey] as? String {
        launchFeedDetailsViewOnNotificationTap(newsId: _newsId)

    }
    
    /**
     
     let userInfo = response.notification.request.content.userInfo
    
    // 2
    if let aps = userInfo["aps"] as? [String: AnyObject],
      let newsItem = NewsItem.makeNewsItem(aps) {
      
      //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
      
      // 3
      if response.actionIdentifier == Identifiers.viewAction,
        let url = URL(string: newsItem.link) {
        let safari = SFSafariViewController(url: url)
        window?.rootViewController?.present(safari, animated: true,
                                            completion: nil)
      }
    }
     */
    
    completionHandler()
  }
}
