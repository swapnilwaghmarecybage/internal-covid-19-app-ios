//
//  QuestionSymptomTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionSymptomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonNoneOfTheAbove: UIButton!
    @IBOutlet weak var buttonCough: UIButton!
    @IBOutlet weak var buttonLossOfTaste: UIButton!
    
    @IBOutlet weak var buttonDifficultyInBreathing: UIButton!
    @IBOutlet weak var buttonFever: UIButton!
    private var arraySymptoms = [String]()
    var delegate: SelfAssistanceManager?
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    @IBOutlet weak var textViewAnswer: UITextView!
    @IBOutlet weak var question: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buttonNext.isHidden = true
        self.buttonCough.isHidden = false
        self.buttonFever.isHidden = false
        self.buttonLossOfTaste.isHidden = false
        self.buttonDifficultyInBreathing.isHidden = false
        self.buttonNoneOfTheAbove.isHidden = false
        
        self.buttonNext.layer.cornerRadius = 5
        self.buttonCough.layer.cornerRadius = 5
        self.buttonFever.layer.cornerRadius = 5
        self.buttonLossOfTaste.layer.cornerRadius = 5
        self.buttonDifficultyInBreathing.layer.cornerRadius = 5
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
                delegate?.adduserAnswers(value: "Qustion: \(self.question.text!)\nAnswer: \(self.textViewAnswer.text!)")

            } else {
                sender.isSelected = !sender.isSelected
                if (sender.isSelected){
                    sender.backgroundColor = UIColor.orange
                    arraySymptoms.append(sender.titleLabel?.text ?? "nil")
                } else {
                    sender.backgroundColor = Theme.selfAssistanceLightPeacockColor
                    if let index = arraySymptoms.firstIndex(of: sender.titleLabel?.text ?? "nil") {
                        arraySymptoms.remove(at: index)
                    }
                }
                if(arraySymptoms.count == 0){
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
        self.buttonCough.isHidden = true
        self.buttonFever.isHidden = true
        self.buttonLossOfTaste.isHidden = true
        self.buttonDifficultyInBreathing.isHidden = true
        self.buttonNoneOfTheAbove.isHidden = true
        self.textViewAnswer.isHidden = false
        heightOfView.constant = 0
        
        if  (self.arraySymptoms.count > 0) {
           // self.labelAnswer.text = "\(self.arraySymptoms.joined(separator: ", "))"
            textViewAnswer.text = "\(self.arraySymptoms.joined(separator: ", "))"
        } else {
            //self.labelAnswer.text = "None of the above"
             textViewAnswer.text = "None of the above"
        }
        //self.labelAnswer.setMargins()

    }
}
