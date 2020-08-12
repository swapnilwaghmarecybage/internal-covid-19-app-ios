//
//  ProtocolFirebasePhoneVerificationResponce.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/11/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import Firebase

protocol FirebasePhoneNumberVerification {
    
    func OTPSendingFailed(errorMessage:String)
    func OTPVerificationFailed(errorMessage: String)
    func OTPSendingSuccessful(verificationID: String)
    func OTPVerificationSuccessful(authResult: AuthDataResult)
    
}
