//
//  SubmitQueryViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/27/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class SubmitQueryViewController: UIViewController {

    @IBOutlet weak var lebelHeadLine: UILabel!
    @IBOutlet weak var textFieldEmployeeName: UITextField!
    @IBOutlet weak var textFieldEmployeeId: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var labelErrorMessage: UILabel!

    
    @IBOutlet weak var textFieldQuery: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let titleAtributes = [NSAttributedString.Key.foregroundColor: Theme.tabselectedColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.paragraphStyle: style ]
        let subtitleAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular), NSAttributedString.Key.paragraphStyle: style ]
        
        
        let title = NSMutableAttributedString(string: "Drop us a query\n", attributes: titleAtributes)
        let subtitle = NSMutableAttributedString(string: "Fill the below details and we will\nhelp you in next 24 hours", attributes: subtitleAtributes)
        let combination = NSMutableAttributedString()
        
        combination.append(title)
        combination.append(subtitle)
        
        self.lebelHeadLine.numberOfLines = 0
        self.lebelHeadLine.attributedText = combination
         if let _username = UserDefaults.standard.value(forKey: USERNAME),
        let _phone = UserDefaults.standard.value(forKey: PHONENUMBER),
            let _employeeid = UserDefaults.standard.value(forKey: EMPLOYEEID){
            
            self.textFieldEmployeeName.text = "\(_username)"
            self.textFieldPhoneNumber.text = "\(_phone)"
            self.textFieldEmployeeId.text = "\(_employeeid)"
        }
        self.textFieldQuery.delegate = self
        self.labelErrorMessage.text = ""
        updateNavigationBar()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -=  keyboardSize.height
        }
    }
}

@objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
    }
}
    @IBAction func onClickSubmit(_ sender: Any) {
        if let query = self.textFieldQuery.text, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
        let username = self.textFieldEmployeeName.text,!username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let phone = self.textFieldPhoneNumber.text,!phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let employeeid = self.textFieldEmployeeId.text, !employeeid.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            let email =  UserDefaults.standard.value(forKey: EMAILID) as? String ?? "swapnilwaghm@cybage.com"
            FirebaseManager.submitQuery(username: username, empployeeId: employeeid, phoneNumber: phone, email:email, query: query)
            goBack()
        } else {
            self.labelErrorMessage.text = "All fields are mandatory"
        }
    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "Query"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SubmitQueryViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            self.labelErrorMessage.text = ""
        }
        return true
    }
}

