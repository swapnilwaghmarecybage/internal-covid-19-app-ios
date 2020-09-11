//
//  QustionContactHistoryForNoSymptomsTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class QustionContactHistoryForNoSymptomsTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonNoneOfTheAbove: UIButton!
    @IBOutlet weak var buttonIAmHealthCareWorker: UIButton!
    @IBOutlet weak var buttonRecentInteraction: UIButton!
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    @IBOutlet weak var textViewAnswer: UITextView!
    @IBOutlet weak var question: UILabel!


        
    
    var delegate: SelfAssistanceManager?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buttonNext.isHidden = true
        self.buttonNoneOfTheAbove.isHidden = false
        self.buttonRecentInteraction.isHidden = false
        self.buttonIAmHealthCareWorker.isHidden = false
        self.buttonNext.layer.cornerRadius = 5
        self.buttonNoneOfTheAbove.layer.cornerRadius = 5
        self.buttonRecentInteraction.layer.cornerRadius = 5
        self.buttonIAmHealthCareWorker.layer.cornerRadius = 5
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
          updateUI(sender: sender)
          delegate?.adduserAnswers(value: "Question: \(self.question.text!):\nAnswer: \(self.textViewAnswer.text!)")
      } else {
        delegate?.updateArray(value: 1000)
        updateUI(sender: sender)
        delegate?.adduserAnswers(value: "Question: \(self.question.text!)\nAnswer: \(self.textViewAnswer.text!)")

        /*
          if(sender.tag == 9) {
              delegate?.updateArray(value: 2)
              updateUI()
          } else {
              sender.isSelected = !sender.isSelected
              if (sender.isSelected){
                  arrayNoSymptomContactHistory.append(sender.titleLabel?.text ?? "nil")
              } else {
                  if let index = arrayNoSymptomContactHistory.firstIndex(of: sender.titleLabel?.text ?? "nil") {
                      arrayNoSymptomContactHistory.remove(at: index)
                  }
              }
              if(arrayNoSymptomContactHistory.count == 0){
                  self.buttonNoneOfTheAbove.isHidden = false
                  self.buttonNext.isHidden = true
              } else {
                  self.buttonNoneOfTheAbove.isHidden = true
                  self.buttonNext.isHidden = false
              }
          }
         */
      }

    }
    
    
    private func updateUI(sender: UIButton) {
          
        self.buttonNext.isHidden = true
        self.buttonNoneOfTheAbove.isHidden = true
        self.buttonRecentInteraction.isHidden = true
        self.buttonIAmHealthCareWorker.isHidden = true
        self.textViewAnswer.isHidden = false
          heightOfView.constant = 0
          
        if  (sender.tag !=  0) {
            self.textViewAnswer.text = "\(sender.titleLabel?.text ?? "")"
          } else {
              self.textViewAnswer.text = "None of the above"
          }
      }
}
