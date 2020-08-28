//
//  SelfAssistanceViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class SelfAssistanceViewController: UIViewController {

    private var arrayScore = [Int]()
    @IBOutlet weak var tableViewSelfAssistance: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
    }

    func updateNavigationBar(){
        self.navigationItem.title = "Self Assistance"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelfAssistanceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return arrayScore.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoInfiTableViewCell", for: indexPath) as? LogoInfiTableViewCell{
                logoCell.configureCell()
                return logoCell
            }
            return UITableViewCell()
        case 1:
            switch arrayScore.count {
            case 0:
                if let symptomsCell = tableView.dequeueReusableCell(withIdentifier: "QuestionSymptomTableViewCell", for: indexPath) as? QuestionSymptomTableViewCell {
                    symptomsCell.delegate = self
                    return symptomsCell
                }
                return UITableViewCell()
            case 1:
                if let previousIllnessCell = tableView.dequeueReusableCell(withIdentifier: "QuestionPreviousIllnessTableViewCell", for: indexPath) as? QuestionPreviousIllnessTableViewCell {
                    previousIllnessCell.delegate = self
                    return previousIllnessCell
                }
                return UITableViewCell()
            case 2:
                let sum = arrayScore[0] + arrayScore[1]
                if sum == 0 {
                    if let travelHistory = tableView.dequeueReusableCell(withIdentifier: "QuestionTravelHistoryTableViewCell", for: indexPath) as? QuestionTravelHistoryTableViewCell {
                        travelHistory.delegate = self
                        return travelHistory
                    }
                } else {
                    if let contactHistoryCell = tableView.dequeueReusableCell(withIdentifier: "QuestionTravelHistoryTableViewCell", for: indexPath) as? QuestionContactHistoryTableViewCell {
                        contactHistoryCell.delegate = self
                        return contactHistoryCell
                    }
                }
                return UITableViewCell()
            case 3:
                let sum = arrayScore[0] + arrayScore[1] + arrayScore[2]
                if(sum == 0){
                    if let contactHistoryNoSymptoms = tableView.dequeueReusableCell(withIdentifier: "QustionContactHistoryForNoSymptomsTableViewCell", for: indexPath) as? QustionContactHistoryForNoSymptomsTableViewCell {
                        contactHistoryNoSymptoms.delegate = self
                        return contactHistoryNoSymptoms
                    }
                } else if (sum == 1){
                    if let resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell {
                        resultCell.delegate = self
                        resultCell.configureCell(message: "Get checked")
                        return resultCell
                    }
                } else {
                    if let resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell {
                        resultCell.delegate = self
                        resultCell.configureCell(message: "Get checked You are ill")
                        return resultCell
                    }
                }
                 return UITableViewCell()
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
               case 0:
                   
                   return 350
               case 1:
                   switch arrayScore.count {
                   case 0:

                       return 330
                   case 1:

                       return 330
                   case 2:
                       let sum = arrayScore[0] + arrayScore[1]
                       if sum == 0 {
                        return 250
                       } else {
                        return 400
                    }
                       
                   case 3:
                       let sum = arrayScore[0] + arrayScore[1] + arrayScore[2]
                       if(sum == 0){
                           return 400
                       } else if (sum == 1){
                           return 500
                       } else {
                          return 500
                       }
                   default:
                       return 0
                   }
               default:
                   return 0
               }
    }
}

extension SelfAssistanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SelfAssistanceViewController: SelfAssistanceManager{
    
    func updateArray(value: Int) {
        self.arrayScore.append(value)
        tableViewSelfAssistance.reloadData()
    }
    func goBackCheckupDone() {
       tableViewSelfAssistance.reloadData()
        self.goBack()
        
    }
}
