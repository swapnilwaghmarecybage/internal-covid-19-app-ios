//
//  UserWelcomeViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/7/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class UserWelcomeViewController: BaseViewController {
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var buttonFeed: UIButton!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonHelpLine: UIButton!
    @IBOutlet weak var buttonSelfAssistance: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelUserName.text = UserDefaults.standard.string(forKey: "username")
        updateNavigationBar()
        decorateUI()
    }
    
    func decorateUI() {
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
    
    func updateNavigationBar(){
        self.navigationItem.title = App_Name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .plain, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.setHidesBackButton(true, animated: true);
    }
    
    @objc func share() {
        self.shareApp()
    }
    
    @IBAction func onClickFeed(_ sender: Any) {
    }
    
    @IBAction func onClickSelfAssistance(_ sender: Any) {
        
    }
    
    @IBAction func onClickHelpLine(_ sender: Any) {
        Utilities.sharedInstance.dialNumber(number: Helpline_Number)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "authVerificationID")
        self.navigationController?.popViewController(animated: true)
    }
}


