//
//  TravelHistoryTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionTravelHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAnswer: UILabel!
    var delegate: SelfAssistanceManager?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        if(sender.tag == 0){
            delegate?.updateArray(value: 0)
        } else {
            delegate?.updateArray(value: 1)
            delegate?.goBackCheckupDone()
        }
    }

}