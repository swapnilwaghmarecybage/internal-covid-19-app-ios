//
//  ResultTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMessage: UITextView!
    @IBOutlet weak var buttonConfirmAndSend: UIButton!
    @IBOutlet weak var buttonIWillDOItLater: UIButton!
    @IBOutlet weak var buttonOk: UIButton!

    
    var delegate: SelfAssistanceManager?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonOk.isHidden = true
        self.buttonConfirmAndSend.isHidden = true
        self.buttonIWillDOItLater.isHidden = true
        
        self.buttonOk.layer.cornerRadius = 5
        self.buttonConfirmAndSend.layer.cornerRadius = 5
        self.buttonIWillDOItLater.layer.cornerRadius = 5
        self.labelMessage.delegate = self
        // Initialization code
    }

    func configureCell(message: String, severity:Int){
        if(severity == 0) {
            self.buttonOk.isHidden = false
            self.buttonConfirmAndSend.isHidden = true
            self.buttonIWillDOItLater.isHidden = true
        } else {
            self.buttonOk.isHidden = true
            self.buttonConfirmAndSend.isHidden = false
            self.buttonIWillDOItLater.isHidden = false

        }
        self.labelMessage.font = .systemFont(ofSize: 15, weight: .bold)
        self.labelMessage.text = message
        
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        if (sender.tag == 9){
            // send data to firebase
            delegate?.sendDataToFirebase()
        }
        delegate?.goBackCheckupDone()
    }

}
extension ResultTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return true
    }
}
