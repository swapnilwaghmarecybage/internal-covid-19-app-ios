//
//  CustomPhoneVerificationAlertProtocol.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/11/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

protocol CustomPhoneVerificationAlert {
    
    func sendOTPToNumber(number:String)
    func verifyOTP(otp:String)
    func loginSuccess(uservalues: Dictionary<String,Any>)
    
}
