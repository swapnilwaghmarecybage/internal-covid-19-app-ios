//
//  AboutViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit
import Firebase

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var buttonSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.backgroundColor
        self.buttonSignIn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert()
        FirebaseManager.delegate = self
    }
    
}


extension AboutViewController: CustomPhoneVerificationAlert{
    
    func verifyOTP(otp: String) {
        if let _verificationID = UserDefaults.standard.string(forKey: "authVerificationID"){
            FirebaseManager.verifyOTPWithFirebase(verificationID: _verificationID, verificationCode: otp)
        }
    }
    
    func sendOTPToNumber(number:String) {
        if(Utilities.sharedInstance.validatePhone(number)){
            FirebaseManager.sendOTPWithFirebase(phoneNumber: number)
        } else {
            AlertView.instance.actionFailure(message: PhoneVerificationErrorCodes.INVALID_PHONE_NUMBER.rawValue)
        }
    }
    
    func loginSuccess(userName: String) {
        UserDefaults.standard.set(userName, forKey: "username")
        if let userWelcomeVc = self.storyboard?.instantiateViewController(withIdentifier: "UserWelcomeViewController") as? UserWelcomeViewController {
            self.navigationController?.pushViewController(userWelcomeVc, animated: true)
        }
    }
}

extension AboutViewController: FirebasePhoneNumberVerification {
    func OTPSendingFailed(errorMessage:String){
        AlertView.instance.actionFailure(message: errorMessage)
    }
    func OTPVerificationFailed(errorMessage: String){
        AlertView.instance.actionFailure(message: errorMessage)
    }
    func OTPSendingSuccessful(verificationID: String){
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        AlertView.instance.OTPReceivedSuccess()
    }
    func OTPVerificationSuccessful(authResult: AuthDataResult){
        AlertView.instance.OTPVerificationSuccess()
    }
}


