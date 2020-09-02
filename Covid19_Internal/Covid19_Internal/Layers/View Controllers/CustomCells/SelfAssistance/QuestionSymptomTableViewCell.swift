//
//  QuestionSymptomTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QuestionSymptomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelAnswer: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonNoneOfTheAbove: UIButton!
    @IBOutlet weak var buttonCough: UIButton!
    @IBOutlet weak var buttonLossOfTaste: UIButton!
    
    @IBOutlet weak var buttonDifficultyInBreathing: UIButton!
    @IBOutlet weak var buttonFever: UIButton!
    private var arraySymptoms = [String]()
    var delegate: SelfAssistanceManager?
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buttonNext.isHidden = true
        self.buttonCough.isHidden = false
        self.buttonFever.isHidden = false
        self.buttonLossOfTaste.isHidden = false
        self.buttonDifficultyInBreathing.isHidden = false
        self.buttonNoneOfTheAbove.isHidden = false
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onClickOption(_ sender: UIButton) {
        
        if(sender.tag == 0){
            delegate?.updateArray(value: 0)
            updateUI()
            
        } else {
            if(sender.tag == 9) {
                delegate?.updateArray(value: 2)
                updateUI()
            } else {
                sender.isSelected = !sender.isSelected
                if (sender.isSelected){
                    arraySymptoms.append(sender.titleLabel?.text ?? "nil")
                } else {
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
        
        heightOfView.constant = 0
        
        if  (self.arraySymptoms.count > 0) {
            self.labelAnswer.text = "  \(self.arraySymptoms.joined(separator: ", "))  "
        } else {
            self.labelAnswer.text = "  None of the above  "
        }
    }
}
