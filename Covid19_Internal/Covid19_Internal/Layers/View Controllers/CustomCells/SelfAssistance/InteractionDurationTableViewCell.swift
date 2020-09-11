//
//  InteractionDurationTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 9/2/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class InteractionDurationTableViewCell: UITableViewCell {

    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    @IBOutlet weak var buttonLessThan5Days: UIButton!
    @IBOutlet weak var buttonGreaterThan5Days: UIButton!
    @IBOutlet weak var buttonGreaterThan14Days: UIButton!
    @IBOutlet weak var textViewAnswer: UITextView!
    @IBOutlet weak var question: UILabel!

    private var arrayInteractionDuration = [String]()

    var delegate: SelfAssistanceManager?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.buttonGreaterThan14Days.layer.cornerRadius = 5
        self.buttonGreaterThan5Days.layer.cornerRadius = 5
        self.buttonLessThan5Days.layer.cornerRadius = 5
        self.textViewAnswer.layer.cornerRadius = 5
        self.textViewAnswer.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        arrayInteractionDuration.append(sender.titleLabel?.text ?? "nil")
        delegate?.updateArray(value: 2)
        updateUI()
        delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: \(self.textViewAnswer.text!)")

        /*
       if(sender.tag == 0){
           delegate?.updateArray(value: 0)
           updateUI()
           
       } else {
        delegate?.updateArray(value: 2)
        updateUI()
        
           if(sender.tag == 9) {
               delegate?.updateArray(value: 2)
               updateUI()
           } else {
               sender.isSelected = !sender.isSelected
               if (sender.isSelected){
                   arrayInteractionDuration.append(sender.titleLabel?.text ?? "nil")
               } else {
                   if let index = arrayInteractionDuration.firstIndex(of: sender.titleLabel?.text ?? "nil") {
                       arrayInteractionDuration.remove(at: index)
                   }
               }
           }
        
       }*/
    }
    
    private func updateUI() {
            
          self.buttonLessThan5Days.isHidden = true
          self.buttonGreaterThan5Days.isHidden = true
          self.buttonGreaterThan14Days.isHidden = true
        self.textViewAnswer.isHidden = false
            heightOfView.constant = 0
            
            if  (self.arrayInteractionDuration.count > 0) {
                self.textViewAnswer.text = "\(self.arrayInteractionDuration.joined(separator: ", "))"
            } else {
                self.textViewAnswer.text = "None of the above"
            }
       // self.labelAnswer.setMargins()

        }
}
