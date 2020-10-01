//
//  AddImageAlertPopup.swift
//  Covid19_Internal
//
//  Created by Mayuri Shekhar on 23/09/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class AddImageAlertPopup: UIView {

       
    static let instance = AddImageAlertPopup()
    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var AlertView: UIView!
    @IBOutlet weak var buttonCamera: UIButton!
    @IBOutlet weak var buttonGallery: UIButton!
    
    var  delegate : AddImageAlert?
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
      Bundle.main.loadNibNamed("AddImageAlertPopup", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        AlertView.layer.cornerRadius = 10
        AlertView.layer.borderColor = UIColor.white.cgColor
        AlertView.layer.borderWidth = 2
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
        
    }
    @IBAction func onClickPhotoAlubm(_ sender: Any) {
        self.dismissPopoup()
        if let _delegate = self.delegate {
            _delegate.addFromAlbum()
        }
        
    }
   
    
    @IBAction func onClickCamera(_ sender: Any) {
        self.dismissPopoup()
        if let _delegate = self.delegate {
                   _delegate.addFromCamera()
               }
    }
    
    
    
@objc func dismissPopoup() {
    parentView.endEditing(true)
    parentView.removeFromSuperview()
    }
    
    
  func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    
    
    
}
