//
//  LogoInfiTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class LogoInfiTableViewCell: UITableViewCell {

    @IBOutlet weak var labelInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(){
        let line1Attributes = [NSAttributedString.Key.foregroundColor: Theme.selfAssistanceLightPeacockColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold) ]
        let line2Attributes = [NSAttributedString.Key.foregroundColor: Theme.selfAssistanceLightPeacockColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular) ]
        let line3Attributes =  [NSAttributedString.Key.foregroundColor: Theme.selfAssistanceLightPeacockColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        
        let line1 = NSMutableAttributedString(string:"Please give correct Answers", attributes: line1Attributes)
        let line2 = NSMutableAttributedString(string: "\nAll the info you have shared with us is protected", attributes: line2Attributes)
        let line3 = NSMutableAttributedString(string: "\nHelp us- Help you", attributes: line3Attributes)
        let combination = NSMutableAttributedString()
        
        combination.append(line1)
        combination.append(line2)
        combination.append(line3)
        
        self.labelInfo.attributedText = combination
    }

}
