//
//  AlertView.swift
//  CustomAlert
//
//  Created by SHUBHAM AGARWAL on 31/12/18.
//  Copyright © 2018 SHUBHAM AGARWAL. All rights reserved.
//

import Foundation
import UIKit

protocol CustomAlert {
    func sendOTPToNumber(number:String)
    func verifyOTP(number:String)
    func loginSuccess()
}

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var buttonAlertAction: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelErrorMessage: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldNumberInput: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var constraintCountryCodeWidth: NSLayoutConstraint!
    
    var delegate: CustomAlert?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        alertView.layer.cornerRadius = 10
        alertView.layer.borderColor = UIColor.white.cgColor
        alertView.layer.borderWidth = 2

        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
   }
    
    
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    
    @IBAction func onClickGenerateOTP(_ sender: UIButton) {
       // parentView.removeFromSuperview()
        if(sender.titleLabel?.text == "GENERATE OTP"){
            if let _delegate = self.delegate, let _mobileNumber = self.textFieldNumberInput.text {
                _delegate.sendOTPToNumber(number: _mobileNumber)
            } else {
                
            }

        } else if (sender.titleLabel?.text == "LOGIN"){
            if let _delegate = self.delegate, let _otp = self.textFieldNumberInput.text {
                _delegate.verifyOTP(number: _otp)
            } else {
                
            }
        }else {
            parentView.removeFromSuperview()
        }
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        if(sender.titleLabel?.text == "CANCEL"){
            parentView.removeFromSuperview()
        }else {
            buttonAlertAction.titleLabel?.text = "GENERATE OTP"
            buttonCancel.titleLabel?.text = "CANCEL"
            self.labelErrorMessage.text = ""
            self.textFieldNumberInput.placeholder = "Mobile Number"
            constraintCountryCodeWidth.constant = 0

        }
    }

    
    func OTPReceivedSuccess(){
        buttonAlertAction.titleLabel?.text = "LOGIN"
        buttonCancel.titleLabel?.text = "BACK"
        self.labelErrorMessage.text = ""
        self.textFieldNumberInput.text = ""
        self.textFieldNumberInput.placeholder = "OTP"
        constraintCountryCodeWidth.constant = 40
    }
    
    
    func OTPVerificationSuccess(){
        self.labelErrorMessage.text = ""
        delegate?.loginSuccess()
        parentView.removeFromSuperview()
    }
    
    func actionFailure(message:String){
        self.labelErrorMessage.text = message
    }
    
}


