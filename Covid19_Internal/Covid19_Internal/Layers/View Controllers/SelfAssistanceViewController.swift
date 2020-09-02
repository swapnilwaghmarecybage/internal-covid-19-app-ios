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
    
    private func symptomCell(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell{
        if let symptomsCell = tableView.dequeueReusableCell(withIdentifier: "QuestionSymptomTableViewCell", for: indexPath) as? QuestionSymptomTableViewCell {
            symptomsCell.delegate = self
            return symptomsCell
        }
        return UITableViewCell()
    }
    
    private func previousIllnesstableView(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell{
        if let previousIllnessCell = tableView.dequeueReusableCell(withIdentifier: "QuestionPreviousIllnessTableViewCell", for: indexPath) as? QuestionPreviousIllnessTableViewCell {
            previousIllnessCell.delegate = self
            return previousIllnessCell
        }
        return UITableViewCell()
    }
    
    private func travelHistory(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell {
        if let travelHistory = tableView.dequeueReusableCell(withIdentifier: "QuestionTravelHistoryTableViewCell", for: indexPath) as? QuestionTravelHistoryTableViewCell {
            travelHistory.delegate = self
            return travelHistory
        }
        return UITableViewCell()
    }
    
    private func contactHistory(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell{
        if let contactHistoryCell = tableView.dequeueReusableCell(withIdentifier: "QuestionContactHistoryTableViewCell", for: indexPath) as? QuestionContactHistoryTableViewCell {
            contactHistoryCell.delegate = self
            return contactHistoryCell
        }
        return UITableViewCell()
    }
    
    private func contactHistorynoSymptoms(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell{
        if let contactHistoryNoSymptoms = tableView.dequeueReusableCell(withIdentifier: "QustionContactHistoryForNoSymptomsTableViewCell", for: indexPath) as? QustionContactHistoryForNoSymptomsTableViewCell {
            contactHistoryNoSymptoms.delegate = self
            return contactHistoryNoSymptoms
        }
        return UITableViewCell()
    }
    
    private func resultCell(tableView: UITableView,indexPath: IndexPath, message: String) -> UITableViewCell{
        if let resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell {
            resultCell.delegate = self
            resultCell.configureCell(message: message)
            return resultCell
        }
        return UITableViewCell()
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
               return symptomCell(tableView: tableView, indexPath: indexPath)
            case 1:
                switch indexPath.row {
                case 0:
                    return symptomCell(tableView: tableView, indexPath: indexPath)
                case 1:
                    return previousIllnesstableView(tableView: tableView, indexPath: indexPath)
                default:
                    return UITableViewCell()
                }
              
            case 2:
                switch indexPath.row {
                case 0:
                    return symptomCell(tableView: tableView, indexPath: indexPath)
                case 1:
                    return previousIllnesstableView(tableView: tableView, indexPath: indexPath)
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                      return  travelHistory(tableView: tableView, indexPath: indexPath)
                    } else {
                        return contactHistory(tableView: tableView, indexPath: indexPath)
                    }
                default:
                    return UITableViewCell()
                }
            case 3:
                
                switch indexPath.row {
                case 0:
                    return symptomCell(tableView: tableView, indexPath: indexPath)
                case 1:
                    return previousIllnesstableView(tableView: tableView, indexPath: indexPath)
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                        return  travelHistory(tableView: tableView, indexPath: indexPath)
                    } else {
                        return contactHistory(tableView: tableView, indexPath: indexPath)
                    }
                case 3:
                    let sum = arrayScore[0] + arrayScore[1] + arrayScore[2]
                    if(sum == 0){
                        return contactHistory(tableView: tableView, indexPath: indexPath)
                    } else if (sum == 1){
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.potentialRisk)
                    } else {
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.potentialRisk)
                    }
                    
                default:
                    return UITableViewCell()
                }
            case 4:
                
                
                switch indexPath.row {
                case 0:
                    return symptomCell(tableView: tableView, indexPath: indexPath)
                case 1:
                    return previousIllnesstableView(tableView: tableView, indexPath: indexPath)
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                        return  travelHistory(tableView: tableView, indexPath: indexPath)
                    } else {
                        return contactHistory(tableView: tableView, indexPath: indexPath)
                    }
                case 3:
                    let sum = arrayScore[0] + arrayScore[1] + arrayScore[2]
                    if(sum == 0){
                        return contactHistory(tableView: tableView, indexPath: indexPath)
                    } else if (sum == 1){
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.potentialRisk)
                    } else {
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.potentialRisk)
                    }
                case 4:
                    let sum = arrayScore[0] + arrayScore[1] + arrayScore[2] + arrayScore[3]
                    if(sum == 0){
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.lowRisk)
                    } else {
                        return resultCell(tableView: tableView, indexPath: indexPath, message: SelfAssesmentMessages.potentialRisk)
                    }
                default:
                    return UITableViewCell()
                }
                
            default: // default case of  array count
                return UITableViewCell()
            }
        default: // deault case of section
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
                switch indexPath.row {
                case 0:
                    return 175
                case 1:
                    return 330
                default:
                    return 50
                }
            case 2:
                
                switch indexPath.row {
                case 0:
                    return 175
                case 1:
                    return 330
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                        return 220
                    } else {
                        return 400
                    }
                default:
                    return 50
                }
                
                
            case 3:
                switch indexPath.row {
                case 0:
                    return 175
                case 1:
                    return 330
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                        return 220
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
                    return 50
                }
            case 4:
                switch indexPath.row {
                case 0:
                    return 175
                case 1:
                    return 330
                case 2:
                    let sum = arrayScore[0] + arrayScore[1]
                    if sum == 0 {
                        return 220
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
                case 4:
                    let sum = arrayScore[0] + arrayScore[1] + arrayScore[2] + arrayScore[3]
                    if(sum == 0){
                        return 400
                    } else {
                        return 500
                    }
                default:
                    return 50
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
        let indexPath = IndexPath(row: self.arrayScore.count, section: 1)
        tableViewSelfAssistance.scrollToRow(
            at: indexPath,
            at: .bottom,
            animated: true)
    }
    func goBackCheckupDone() {
        tableViewSelfAssistance.reloadData()
        self.goBack()
        
    }
}
