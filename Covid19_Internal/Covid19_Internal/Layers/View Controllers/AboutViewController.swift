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
        if let _ = UserDefaults.standard.value(forKey: USERNAME){
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
        self.labelUserName.text = UserDefaults.standard.string(forKey: USERNAME)

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
        if let selfAssistanceVC = self.storyboard?.instantiateViewController(withIdentifier: "SelfAssistanceViewController") as? SelfAssistanceViewController {
            self.navigationController?.pushViewController(selfAssistanceVC, animated: true)
        }
    }
    
    @IBAction func onClickHelpLine(_ sender: Any) {
        
        HelpLinePopup.instance.delegate = self
        HelpLinePopup.instance.showAlert()

    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        
        FirebaseManager.updateSignInStatusInFirebase(is_loggedin: false) { (success) in
           
            DispatchQueue.main.async {
                UserDefaults.standard.removeObject(forKey: USERNAME)
                UserDefaults.standard.removeObject(forKey: PHONENUMBER)
                UserDefaults.standard.removeObject(forKey: EMAILID)
                UserDefaults.standard.removeObject(forKey: EMPLOYEEID)

                UserDefaults.standard.removeObject(forKey: "authVerificationID")

                self.setupAboutView()
            }
        }
        
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
    
    func loginSuccess(uservalues: Dictionary<String,Any>) {
        UserDefaults.standard.set(uservalues["username"], forKey: USERNAME)
        UserDefaults.standard.set(uservalues["phone"], forKey: PHONENUMBER)
        UserDefaults.standard.set(uservalues["employeeid"], forKey: EMPLOYEEID)
        UserDefaults.standard.set(uservalues["emailid"], forKey: EMAILID)

        FirebaseManager.updateSignInStatusInFirebase(is_loggedin: true) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.setupUserWelcomeView()
                    (UIApplication.shared.delegate as? AppDelegate)?.setupNotificationForApplication()
                }
            }
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

extension AboutViewController: HelpLineAlert{
    func justACall() {
        if let helpLineVC = self.storyboard?.instantiateViewController(withIdentifier: "HelplineViewController") as? HelplineViewController {
                  self.navigationController?.pushViewController(helpLineVC, animated: true)
              }
    }
    
    func justAQuery() {
        if let submitQueryVC = self.storyboard?.instantiateViewController(withIdentifier: "SubmitQueryViewController") as? SubmitQueryViewController {
                  self.navigationController?.pushViewController(submitQueryVC, animated: true)
              }
    }
}


