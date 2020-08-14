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
    
    @IBOutlet var viewAbout: UIView!
    
    @IBOutlet var viewUserWelcome: UIView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var buttonFeed: UIButton!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonHelpLine: UIButton!
    @IBOutlet weak var buttonSelfAssistance: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: "username"){
            //userwelcome
            setupUserWelcomeView()
        } else {
            //aboutview
            setupAboutView()
        }
        self.view.backgroundColor = Theme.backgroundColor
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupAboutView() {
        self.view = viewAbout
        self.buttonSignIn.layer.cornerRadius = 5
    }
    
    func setupUserWelcomeView(){
        self.view = viewUserWelcome
        decorateUI()
        self.labelUserName.text = UserDefaults.standard.string(forKey: "username")

    }
    private func decorateUI() {
        self.buttonHelpLine.titleLabel?.lineBreakMode = .byWordWrapping;
        self.buttonHelpLine.titleLabel?.numberOfLines = 2
        self.buttonSelfAssistance.titleLabel?.lineBreakMode = .byWordWrapping;
        self.buttonSelfAssistance.titleLabel?.numberOfLines = 2
        
        self.buttonFeed.titleLabel?.textAlignment = .center
        self.buttonLogout.titleLabel?.textAlignment = .center
        self.buttonHelpLine.titleLabel?.textAlignment = .center
        self.buttonSelfAssistance.titleLabel?.textAlignment = .center
        
        self.buttonFeed.layer.cornerRadius = 10
        self.buttonLogout.layer.cornerRadius = 10
        self.buttonHelpLine.layer.cornerRadius = 10
        self.buttonSelfAssistance.layer.cornerRadius = 10
        
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        
        AlertView.instance.delegate = self
        AlertView.instance.showAlert()
        FirebaseManager.delegatePhoneVerification = self
        
    }
    @IBAction func onClickFeed(_ sender: Any) {
        if let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedListViewController") as? FeedListViewController {
            self.navigationController?.pushViewController(feedVC, animated: true)
        }
    }
    
    @IBAction func onClickSelfAssistance(_ sender: Any) {
        
    }
    
    @IBAction func onClickHelpLine(_ sender: Any) {
        Utilities.sharedInstance.dialNumber(number: Helpline_Number)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "authVerificationID")
        setupAboutView()
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
        setupUserWelcomeView()
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


