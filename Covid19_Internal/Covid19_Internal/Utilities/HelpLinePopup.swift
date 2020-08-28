//
//  HelpLinePopup.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/27/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
//
//  AlertView.swift
//  CustomAlert
//
//  Created by SHUBHAM AGARWAL on 31/12/18.
//  Copyright © 2018 SHUBHAM AGARWAL. All rights reserved.
//

import Foundation
import UIKit

class HelpLinePopup: UIView {
    
    static let instance = HelpLinePopup()
    
    @IBOutlet weak var alertViewHelpLine: UIView!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonQuery: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var parentView: HelpLinePopup!
    
    var delegate: HelpLineAlert?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("HelpLinePopup", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        alertViewHelpLine.layer.cornerRadius = 10
        alertViewHelpLine.layer.borderColor = UIColor.white.cgColor
        alertViewHelpLine.layer.borderWidth = 2

        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissPopoup() {
        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }
    
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
        
  
    
    @IBAction func onClickQuery(_ sender: Any) {
        dismissPopoup()
    if let _delegate = self.delegate {
        _delegate.justAQuery()
        }

    }
    @IBAction func onClickCall(_ sender: Any) {
        dismissPopoup()
    if let _delegate = self.delegate {
        _delegate.justACall()
        }

    }
}

