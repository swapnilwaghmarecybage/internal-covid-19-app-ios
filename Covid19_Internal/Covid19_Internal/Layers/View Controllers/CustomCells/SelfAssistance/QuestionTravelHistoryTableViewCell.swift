//
//  TravelHistoryTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionTravelHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonNo: UIButton!
    
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    @IBOutlet weak var textViewAnswer: UITextView!

    var delegate: SelfAssistanceManager?
    private var arrayTravelHistory = [String]()
    @IBOutlet weak var question: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buttonNo.isHidden = false
        self.buttonYes.isHidden = false
        
        self.buttonNo.layer.cornerRadius = 5
        self.buttonYes.layer.cornerRadius = 5
        self.textViewAnswer.layer.cornerRadius = 5
        self.textViewAnswer.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        if(sender.tag == 0){
            self.textViewAnswer.text = "\("NO")"
            delegate?.updateArray(value: 0)
            delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: NO")
        } else {
            self.textViewAnswer.text = "\("YES")"
            delegate?.updateArray(value: 1)
            delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: YES")

            //delegate?.goBackCheckupDone()
        }
        self.textViewAnswer.isHidden = false
        self.buttonYes.isHidden = true
        self.buttonNo.isHidden = true
        self.heightOfView.constant = 0
        //self.labelAnswer.setMargins()

    }

}
