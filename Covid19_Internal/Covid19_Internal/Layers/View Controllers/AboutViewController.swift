//
//  AboutViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

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

    }
    
    
}


extension AboutViewController: CustomAlert{
    
    func sendOTPToNumber(number:String){
        if(Utilities.sharedInstance.validatePhone(number)){
            AlertView.instance.OTPReceivedSuccess()
            
        } else {
            AlertView.instance.actionFailure(message: "Please enter valid phone number")
        }
        
    }
    
    func verifyOTP(number:String){
        if(number == "123456"){
            AlertView.instance.OTPVerificationSuccess()
        } else {
            AlertView.instance.actionFailure(message: "OTP verification Failed")
        }
    }
    func loginSuccess(){
        
        if let userWelcomeVc = self.storyboard?.instantiateViewController(withIdentifier: "UserWelcomeViewController") as? UserWelcomeViewController {
         self.navigationController?.pushViewController(userWelcomeVc, animated: true)
         }

    }

}
