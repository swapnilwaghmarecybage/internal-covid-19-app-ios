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
    
    static var delegate: FirebasePhoneNumberVerification?
    static func configure() {
        FirebaseApp.configure()
    }
    
    static func sendOTPWithFirebase(phoneNumber:String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("Error \(error.localizedDescription)" )
                delegate?.OTPSendingFailed(errorMessage: PhoneVerificationErrorCodes.OTP_SENDING_FAILED.rawValue)
                
            } else {
                print("verification successful")
                if let _verificationID = verificationID {
                    delegate?.OTPSendingSuccessful(verificationID: _verificationID)
                    
                } else {
                    delegate?.OTPSendingFailed(errorMessage: PhoneVerificationErrorCodes.NULL_VERIFICATIONID.rawValue)
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
                delegate?.OTPVerificationFailed(errorMessage: PhoneVerificationErrorCodes.OTP_VERIFICATION_FAILED.rawValue)
            } else {
                if let _authResult = authResult {
                    delegate?.OTPVerificationSuccessful(authResult: _authResult)
                } else {
                    delegate?.OTPVerificationFailed(errorMessage: PhoneVerificationErrorCodes.NULL_AUTH.rawValue)
                }
            }
        }
    }
}
