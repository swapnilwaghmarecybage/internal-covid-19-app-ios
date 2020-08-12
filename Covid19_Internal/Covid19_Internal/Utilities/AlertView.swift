//
//  AlertView.swift
//  CustomAlert
//
//  Created by SHUBHAM AGARWAL on 31/12/18.
//  Copyright © 2018 SHUBHAM AGARWAL. All rights reserved.
//

import Foundation
import UIKit

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var shadowView: UIView!

    @IBOutlet weak var alertViewMobileNumberAndName: UIView!
    @IBOutlet weak var labelTitleAlertViewMobileNumberAndName: UILabel!
    @IBOutlet weak var labelMessageAlertViewMobileNumberAndName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldNumberInput: UITextField!
    @IBOutlet weak var labelErrorMessageAlertViewMobileNumberAndName: UILabel!
    @IBOutlet weak var buttonGenerateOTP: UIButton!
    @IBOutlet weak var buttonResendOTP: UIButton!

    @IBOutlet weak var alertViewOTP: UIView!
    @IBOutlet weak var labelTitleAlertViewOTP: UILabel!
    @IBOutlet weak var labelMessageAlertViewOTP: UILabel!
    @IBOutlet weak var textFieldOTP: UITextField!
    @IBOutlet weak var labelErrorMessageAlertViewOTP: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!

    private let ganarateButtonTitle = "GENERATE OTP"
    private let resendButtonTitle = "RESEND OTP"
    private let loginButtonTitle = "LOGIN"
    private let placeholderName = "Name"
    private let placeholderNumber = "Mobile Number"
    private let placeholderOTP = "OTP"
    private let OTPViewMessage = "Please enter OTP received\non your mobile number"
    private let NumberNameViewMessage = "Please enter name and mobile number to receive OTP"


    
    var delegate: CustomPhoneVerificationAlert?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        alertViewMobileNumberAndName.layer.cornerRadius = 10
        alertViewMobileNumberAndName.layer.borderColor = UIColor.white.cgColor
        alertViewMobileNumberAndName.layer.borderWidth = 2
        
        alertViewOTP.layer.cornerRadius = 10
        alertViewOTP.layer.borderColor = UIColor.white.cgColor
        alertViewOTP.layer.borderWidth = 2

        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        alertViewOTP.isHidden = true
        alertViewMobileNumberAndName.isHidden = false
        setupAlertViewMobileNumberAndName()
        setupAlertViewOTP()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
        
    }
    
    private func setupAlertViewMobileNumberAndName() {
        self.labelTitleAlertViewMobileNumberAndName.text = loginButtonTitle
        self.labelMessageAlertViewMobileNumberAndName.text = NumberNameViewMessage
        self.textFieldName.text = ""
        self.textFieldNumberInput.text = ""
        self.textFieldName.placeholder = placeholderName
        self.textFieldNumberInput.placeholder = placeholderNumber
        self.labelErrorMessageAlertViewMobileNumberAndName.text = ""
        self.buttonGenerateOTP.isEnabled = true
        self.buttonGenerateOTP.alpha = 1.0
        self.buttonResendOTP.isEnabled = false
        self.buttonResendOTP.alpha = 0.5

        textFieldNumberInput.leftViewMode = .always
        let flagImage =  UIImage(named: "indiaflag")
        let leftView = UIImageView(image:flagImage)
        let viewImageHolder = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        viewImageHolder.backgroundColor = UIColor.clear
        leftView.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        viewImageHolder.addSubview(leftView)
        self.textFieldNumberInput.leftView = viewImageHolder

    }
    
    private func setupAlertViewOTP() {
        self.labelTitleAlertViewOTP.text = loginButtonTitle
        self.labelMessageAlertViewOTP.text = OTPViewMessage
        self.textFieldOTP.text = ""
        self.textFieldOTP.placeholder = placeholderOTP
        self.textFieldOTP.isSecureTextEntry = true
        self.labelErrorMessageAlertViewMobileNumberAndName.text = ""
    }
    
    @objc func dismissPopoup() {
        parentView.endEditing(true)
        parentView.removeFromSuperview()
        alertViewOTP.isHidden = true
        alertViewMobileNumberAndName.isHidden = false
        setupAlertViewMobileNumberAndName()
        setupAlertViewOTP()
    }
    
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
        
    @IBAction func onClickSendOTP(_ sender: UIButton) {
        if let _delegate = self.delegate {
            if let _mobileNumber = self.textFieldNumberInput.text, !_mobileNumber.isEmpty,
                let name = self.textFieldName.text, !name.isEmpty {
                if (sender.titleLabel?.text == "GENERATE OTP"){
                    self.buttonGenerateOTP.isEnabled = false
                    self.buttonGenerateOTP.alpha = 0.5
                } else {
                    self.buttonResendOTP.isEnabled = false
                    self.buttonResendOTP.alpha = 0.5
                }
                _delegate.sendOTPToNumber(number: "+91\(_mobileNumber)")

            } else {
                self.labelErrorMessageAlertViewMobileNumberAndName.text = "please enter username and Mobile Number"
            }
        }
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        if let _delegate = self.delegate, let _otp = self.textFieldOTP.text, !_otp.isEmpty {
                _delegate.verifyOTP(otp: _otp)
            } else {
            self.labelErrorMessageAlertViewOTP.text = PhoneVerificationErrorCodes.OTP_EMPTY.rawValue
            }
        }
    
    func OTPReceivedSuccess(){
        self.alertViewMobileNumberAndName.isHidden = true
        self.alertViewOTP.isHidden = false
    }
    
    
    func OTPVerificationSuccess(){
        delegate?.loginSuccess(userName: self.textFieldName.text ?? "")
        self.dismissPopoup()
    }
    
    func actionFailure(message:String) {
        
        if(self.alertViewMobileNumberAndName.isHidden) {
            self.labelErrorMessageAlertViewOTP.text = message
        }else {
            self.labelErrorMessageAlertViewMobileNumberAndName.text = message
            if (message == PhoneVerificationErrorCodes.OTP_SENDING_FAILED.rawValue
                || message == PhoneVerificationErrorCodes.NULL_VERIFICATIONID.rawValue ){
                self.buttonResendOTP.isEnabled = true
                self.buttonResendOTP.alpha = 1.0
            } else if (message == PhoneVerificationErrorCodes.INVALID_PHONE_NUMBER.rawValue ||
                message == PhoneVerificationErrorCodes.FIELDS_EMPTY.rawValue){
                self.buttonGenerateOTP.isEnabled = true
                self.buttonGenerateOTP.alpha = 1.0
            }
        }
        
    
    }
}


extension AlertView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.textFieldName){
            self.textFieldNumberInput.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.textFieldNumberInput){
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10

        } else if (textField == self.textFieldName){
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 20
        }
        return true
    }
}
