//
//  QuestionPreviousIllnessTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionPreviousIllnessTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAnswer: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonNoneOfTheAbove: UIButton!
    @IBOutlet weak var buttonDibetes: UIButton!
    @IBOutlet weak var buttonHeartDisease: UIButton!
    @IBOutlet weak var buttonLungDisease: UIButton!
    
    @IBOutlet weak var buttonHypertension: UIButton!
    @IBOutlet weak var buttonKidneyDisorder: UIButton!
    
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
           delegate?.updateArray(value: 2)
        }
        self.labelAnswer.text = "  \(sender.titleLabel?.text ?? "")  "

    }

}
