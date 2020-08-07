//
//  UserWelcomeViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/7/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class UserWelcomeViewController: UIViewController {

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
        self.buttonFeed.layer.cornerRadius = 5
        self.buttonLogout.layer.cornerRadius = 5
        self.buttonHelpLine.layer.cornerRadius = 5
        self.buttonSelfAssistance.layer.cornerRadius = 5

    }
    
    func updateNavigationBar(){
        self.navigationItem.title = App_Name
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onClickFeed(_ sender: Any) {
    }
    
    @IBAction func onClickSelfAssistance(_ sender: Any) {
    
    }
    @IBAction func onClickHelpLine(_ sender: Any) {
    
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
        goBack()
    }
}


