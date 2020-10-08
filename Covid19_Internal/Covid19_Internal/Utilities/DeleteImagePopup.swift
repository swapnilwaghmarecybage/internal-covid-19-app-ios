//
//  DeleteImagePopup.swift
//  Covid19_Internal
//
//  Created by Mayuri Shekhar on 07/10/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class DeleteImagePopup: UIView {

    static let instance = DeleteImagePopup()
    var delegate : DeleteImageAlert!
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var deleteImageView: UIView!
   
  
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var LableAlertTitle: UILabel!
    
    @IBOutlet weak var buttonDelete: UIButton!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
          Bundle.main.loadNibNamed("DeleteImagePopup", owner: self, options: nil)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
           
        }
        
        private func commonInit() {
            deleteImageView.layer.cornerRadius = 10
            deleteImageView.layer.borderColor = UIColor.white.cgColor
            deleteImageView.layer.borderWidth = 2
            
            parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(dismissPopoup))
            shadowView.addGestureRecognizer(tapGesture)
           
            
    }
   
    
    @IBAction func onclickCancel(_ sender: Any) {
        self.dismissPopoup()
    }
    @IBAction func onClickDelete(_ sender: Any) {
        self.dismissPopoup()
        if let _delegate = self.delegate{
            _delegate.deleteImage()
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
