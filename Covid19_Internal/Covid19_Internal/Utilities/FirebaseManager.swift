//
//  FirebaseManager.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/11/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import Firebase


struct FirebaseManager {
    
    static var delegatePhoneVerification: FirebasePhoneNumberVerification?
    static var arrayNews = [NewsModel]()
    static var delegateFeedsResponce: FirebaseFeedResponse?

    static func configure() {
        FirebaseApp.configure()
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
    
    static func fetchAllNewsFromFirebase(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if let referance = ref?.child("covid_care") {
            referance.observe(.value, with: { snapshot in
                if let allNews = snapshot.value as? [String: Dictionary<String,Any>] {
                    for object in allNews {
                        let currentNews =  object.value
                        var news = NewsModel()
                        news.content = currentNews["content"] as? String
                        news.date = currentNews["date"] as? String
                        news.link = currentNews["link"] as? String
                        news.title = currentNews["title"] as? String
                        news.photo = currentNews["photo"] as? String
                        news.subject = currentNews["subject"] as? String
                        news.id = object.key
                        arrayNews.append(news)
                    }
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
}
