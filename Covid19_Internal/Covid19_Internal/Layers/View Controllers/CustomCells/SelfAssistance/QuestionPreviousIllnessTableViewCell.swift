//
//  QuestionPreviousIllnessTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionPreviousIllnessTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonNoneOfTheAbove: UIButton!
    @IBOutlet weak var buttonDibetes: UIButton!
    @IBOutlet weak var buttonHeartDisease: UIButton!
    @IBOutlet weak var buttonLungDisease: UIButton!
    
    @IBOutlet weak var buttonHypertension: UIButton!
    @IBOutlet weak var buttonKidneyDisorder: UIButton!
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    private var arrayPreviousIllness = [String]()
    @IBOutlet weak var textViewAnswer: UITextView!
    @IBOutlet weak var question: UILabel!



    var delegate: SelfAssistanceManager?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buttonNext.isHidden = true
        self.buttonDibetes.isHidden = false
        self.buttonLungDisease.isHidden = false
        self.buttonHeartDisease.isHidden = false
        self.buttonHypertension.isHidden = false
        self.buttonKidneyDisorder.isHidden = false
        self.buttonNoneOfTheAbove.isHidden = false
        
        self.buttonNext.layer.cornerRadius = 5
        self.buttonDibetes.layer.cornerRadius = 5
        self.buttonLungDisease.layer.cornerRadius = 5
        self.buttonHeartDisease.layer.cornerRadius = 5
        self.buttonHypertension.layer.cornerRadius = 5
        self.buttonKidneyDisorder.layer.cornerRadius = 5
        self.buttonNoneOfTheAbove.layer.cornerRadius = 5
        self.textViewAnswer.isHidden = true
        self.textViewAnswer.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        if(sender.tag == 0){
            delegate?.updateArray(value: 0)
            updateUI()
            delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: \(self.textViewAnswer.text!)")

        } else {
            if(sender.tag == 9) {
                delegate?.updateArray(value: 2)
                updateUI()
                delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: \(self.textViewAnswer.text!)")

            } else {
                sender.isSelected = !sender.isSelected
                if (sender.isSelected){
                    sender.backgroundColor = UIColor.orange
                    arrayPreviousIllness.append(sender.titleLabel?.text ?? "nil")
                } else {
                    sender.backgroundColor = Theme.selfAssistanceLightPeacockColor

                    if let index = arrayPreviousIllness.firstIndex(of: sender.titleLabel?.text ?? "nil") {
                        arrayPreviousIllness.remove(at: index)
                    }
                }
                if(arrayPreviousIllness.count == 0){
                    self.buttonNoneOfTheAbove.isHidden = false
                    self.buttonNext.isHidden = true
                } else {
                    self.buttonNoneOfTheAbove.isHidden = true
                    self.buttonNext.isHidden = false
                }
            }
        }
        
    }

    private func updateUI() {
        
        self.buttonNext.isHidden = true
        self.buttonDibetes.isHidden = true
        self.buttonLungDisease.isHidden = true
        self.buttonHeartDisease.isHidden = true
        self.buttonHypertension.isHidden = true
        self.buttonKidneyDisorder.isHidden = true
        self.buttonNoneOfTheAbove.isHidden = true
        self.textViewAnswer.isHidden = false
        heightOfView.constant = 0
        
        if  (self.arrayPreviousIllness.count > 0) {
            self.textViewAnswer.text = "\(self.arrayPreviousIllness.joined(separator: ", "))"
        } else {
            self.textViewAnswer.text = "None of the above"
        }
       // self.labelAnswer.setMargins()

    }
    
}
