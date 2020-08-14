//
//  NavigationVC.swift
//  CYBSocketChat
//
//  Created by Ghanshyam Maliwal on 5/10/16.
//  Copyright © 2016 Cybage. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController , UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    /// TapGesture , it stops any ongoing editing . It downs keyboard.
    var tapGesture : UITapGestureRecognizer!
    
    // MARK: - Super Class Methods
    
    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.navigationBar.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        self.navigationBar.barTintColor = Theme.navogationBarbackgroundColor
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let supportedOrientations = self.topViewController?.supportedInterfaceOrientations {
            return supportedOrientations
        } else {
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        if let shouldrotate = self.topViewController?.shouldAutorotate {
            return shouldrotate
        } else {
            return false
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        if let prefferedStatusBarHiddenOption = self.topViewController?.prefersStatusBarHidden {
            return prefferedStatusBarHiddenOption
        }
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let prefferedOrientation = self.topViewController?.preferredInterfaceOrientationForPresentation {
            return prefferedOrientation
        } else {
            return .portrait
        }
    }
    
    // MARK: - Instance Method
    
    /**
     It stops any ongoing editing . It downs keyboard
     */
    @objc func tapAction() {
        self.view.endEditing(true)
    }
}
