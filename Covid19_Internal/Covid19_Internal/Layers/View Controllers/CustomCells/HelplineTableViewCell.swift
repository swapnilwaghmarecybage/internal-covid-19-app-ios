//
//  HelplineTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/25/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class HelplineTableViewCell: UITableViewCell {

    @IBOutlet weak var textViewHelpLine: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textViewHelpLine.delegate  = self
    }

    func configureCell(text:String){
        self.textViewHelpLine.text = text
    }

}


extension HelplineTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
      
        NSLog("@@@###@@@ Helpline number URL: %@",URL.absoluteString )
        if let number = URL.absoluteString.components(separatedBy: ":").last {
            Utilities.sharedInstance.dialNumber(number: number)
        }
        return true
    }
}
