//
//  FirebaseManager.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/11/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct FirebaseManager {
    
    static var delegatePhoneVerification: FirebasePhoneNumberVerification?
    static var arrayNews = [NewsModel]()
    static var helplineData = [String: String]()
    static var delegateFeedsResponce: FirebaseFeedResponse?

    static func configure() {
        FirebaseApp.configure()
        insertDeviceInformation()
    }
    

    
    static func sendOTPWithFirebase(phoneNumber:String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("Error \(error.localizedDescription)" )
                delegatePhoneVerification?.OTPSendingFailed(errorMessage: PhoneVerificationErrorCodes.OTP_SENDING_FAILED.rawValue)
                
            } else {
                print("verification successful")
                if let _verificationID = verificationID {
                    delegatePhoneVerification?.OTPSendingSuccessful(verificationID: _verificationID)
                    
                } else {
                    delegatePhoneVerification?.OTPSendingFailed(errorMessage: PhoneVerificationErrorCodes.NULL_VERIFICATIONID.rawValue)
                }
            }
        }
    }
    
    static func verifyOTPWithFirebase(verificationID: String, verificationCode: String){
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Error \(error.localizedDescription)" )
                delegatePhoneVerification?.OTPVerificationFailed(errorMessage: PhoneVerificationErrorCodes.OTP_VERIFICATION_FAILED.rawValue)
            } else {
                if let _authResult = authResult {
                    delegatePhoneVerification?.OTPVerificationSuccessful(authResult: _authResult)
                } else {
                    delegatePhoneVerification?.OTPVerificationFailed(errorMessage: PhoneVerificationErrorCodes.NULL_AUTH.rawValue)
                }
            }
        }
    }
    
    static func fetchAllNewsFromFirebase() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if let referance = ref?.child("covid_care") {
            referance.observe(.value, with: { snapshot in
                if let allNews = snapshot.value as? [String: Dictionary<String,Any>] {
                    arrayNews.removeAll()
                    for object in allNews {
                        let currentNews =  object.value
                        var news = NewsModel()
                        news.content = currentNews["content"] as? String
                        news.date = currentNews["date"] as? Double
                        news.link = currentNews["link"] as? String
                        news.title = currentNews["title"] as? String
                        news.photo = currentNews["photo"] as? String
                        news.subject = currentNews["subject"] as? String
                        news.id = object.key
                        arrayNews.append(news)
                    }
                    if let deletedNews = DBManager.fetchIds(){
                        arrayNews = arrayNews.filter { !deletedNews.contains($0.id ?? "")}
                    }
                   arrayNews = arrayNews.sorted(by: {$0.date ?? 0 > $1.date ?? 0})
                    delegateFeedsResponce?.feedsReceivedSuccess()
                }
            })
            
            referance.observe(.childAdded, with: { (snapshot) -> Void in
                //arrayNews.append(snapshot)
                //self.tableView.insertRows(at: [IndexPath(row: self.comments.count-1, section: self.kSectionComments)], with: UITableView.RowAnimation.automatic)
                print("New object added : \(snapshot)")
            })
            // Listen for deleted comments in the Firebase database
            referance.observe(.childRemoved, with: { (snapshot) -> Void in
               // let index = self.indexOfMessage(snapshot)
                //arrayNews.remove(at: index)
                //self.tableView.deleteRows(at: [IndexPath(row: index, section: self.kSectionComments)], with: UITableView.RowAnimation.automatic)
            print("New object Removed : \(snapshot)")

            })
        }
    }
    
   static func checkIfNumerIsRegistered(number: String,  completion: @escaping (Bool)->Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if let referance = ref?.child("registered_users") {
            referance.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if snapshot.hasChild(number){
                    completion(true)
                }else{
                    print("false number doesn't exist")
                    completion(false)
                }
                
            }) { (error) in
                completion(false)
            }
        }
    }
    
    func updateUserNameForMobileNumber(number:String, username:String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if let referance = ref?.child("registered_users") {
            referance.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                snapshot.setValue(username, forKey: number)
            }) { (error) in
                print(error.localizedDescription)
                print("Failed to update user name \(username) in table registered_users for mobile number \(number)")
            }
        }

    }
    
    static func updateSignInStatusInFirebase(is_loggedin:Bool, completion: @escaping (Bool) -> Void) {
        // change this with device id stored in keychain
        if let _deviceId = UUID {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            if let referance = ref{
                referance.child("app_users").child(_deviceId) .updateChildValues(["is_loggedin": is_loggedin])
                completion(true)
            }else {
                completion(false)
            }
        }
    }
    
   private static func insertDeviceInformation() {
    
        if let _deviceId = UUID {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            if let referance = ref {
               let isLoggedIn = UserDefaults.standard.value(forKey: USERNAME) != nil ? true : false
                let fmc_token = UserDefaults.standard.value(forKey: FCM_TOKEN) as? String ?? ""
                referance.child("app_users").child(_deviceId).updateChildValues(["device_id": _deviceId,
                                    "fcm_token": fmc_token,
                                    "is_loggedin": isLoggedIn])
                
                
            }

        }
    }
    
    static func updateFCMToken(token:String) {
        let fcm_token = Messaging.messaging().fcmToken ?? ""
        UserDefaults.standard.set(fcm_token, forKey: FCM_TOKEN)

        if let _deviceId = UUID {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            if let referance = ref {
                referance.child("app_users").child(_deviceId).updateChildValues( ["fcm_token": fcm_token])
            } else {
                print("database not found.Failed to update FCM Token on database")
            }

        }

    }
    
    static func getNewsForId(newsId: String, completion: @escaping (NewsModel?)-> Void){
        var ref: DatabaseReference!
              ref = Database.database().reference()
        if let referance = ref {
                referance.child("covid_care").child(newsId).observe(.value, with: { snapshot in
                    print(snapshot)
                    if let fetchedNews = snapshot.value as? Dictionary<String, Any>{
                        var news = NewsModel()
                        news.content = fetchedNews["content"] as? String
                        news.title = fetchedNews["title"] as? String
                        news.date = fetchedNews["date"] as? Double
                        news.link = fetchedNews["link"] as? String
                        news.subject = fetchedNews["subject"] as? String
                        news.photo = fetchedNews["photo"] as? String
                        news.id = snapshot.key
                        completion(news)
                    }
                }){ (error) in
                    print(error)
                    completion(nil)
                }
        } else {
            print("database not found")
        }
    }
    
    static func getHelplineData(completion: @escaping (Dictionary<String,String>?)->Void){
        var ref: DatabaseReference!
              ref = Database.database().reference()
        if let referance = ref {
            referance.child("helpline").observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if let helpline = snapshot.value as? Dictionary<String, String>{
                   // self.helplineData = helpline
                    completion(helpline)
                } else {
                    completion(nil)
                }
            }) { (error) in
                print(error.localizedDescription)
                completion(nil)
            }
        } else {
            print("databadse not found")
        }
    }
    
    
     static func submitQuery(username:String, empployeeId: Int,
                             phoneNumber: Int, email:String, query: String) {
     
             var ref: DatabaseReference!
             ref = Database.database().reference()
             if let referance = ref {
                referance.child("queries").childByAutoId().updateChildValues(["username": username,
                                     "employeeId": empployeeId,
                                     "phoneNumber": phoneNumber,
                                     "query":query,
                                     "email": email,
                                     "timestamp": "\(Date().currentTimeMillis())" ])
                 
             } else {
                print("database not found")
            }
     }
    
    
    static func submitSelfAssistanceStatus(username:String, employeeId: Int,
    phoneNumber: Int, email:String, status: String){
        
         var ref: DatabaseReference!
         ref = Database.database().reference()
         if let referance = ref {
            referance.child("self-assistance").childByAutoId().updateChildValues(["username": username,
                                 "employeeId": employeeId,
                                 "phoneNumber": phoneNumber,
                                 "status":status,
                                 "email": email,
                                 "timestamp": "\(Date().currentTimeMillis())" ])
             
         } else {
            print("database not found")
        }
    }
    
    static func verifyIfCybagian(number: String,  completion: @escaping (Bool, Dictionary<String, Any>?)->Void){
         var ref: DatabaseReference!
         ref = Database.database().reference()
         if let referance = ref {
            referance.child("cybagians").queryOrdered(byChild: "phone").queryEqual(toValue: Int(number)).observeSingleEvent(of: .value) { (snapshot) in
                //print(snapshot)
                if let userdata = snapshot.value as? Dictionary<String, Any>, let user = userdata.first{
                    if let values = user.value as? Dictionary<String, Any> {
                        completion(true, values)

                    } else {
                        completion(false, nil)
                    }
                }else{
                    completion(false, nil)
                }
            }
         }else{
            completion(false, nil)
        }
     }
}
