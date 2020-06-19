//
//  HomeViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var viewModelHomeTab:HomeTabViewModel?
    
    @IBOutlet weak var dataSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewCovidData: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSelectionSegmentControl.addBorder(borderWidth: 1.0, borderColor: UIColor.white, cornerRadius: 0.5)
        dataSelectionSegmentControl.updateTextColor()
        
        viewModelHomeTab = HomeTabViewModel();
        viewModelHomeTab?.getCountriesData(completion: { (success) in
            if(success){
            // refresh tableview
            }
        })
    }
    
    
    @IBAction func onClickSegmentControlOption(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue){
            print("India Selected")
        } else {
            print("World Selected")
        }
        tableViewCovidData.reloadData()
    }

}
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let parentCountCell = tableView.dequeueReusableCell(withIdentifier: "TotalCountTableViewCell", for: indexPath) as? TotalCountTableViewCell{
             return parentCountCell
            }
            return UITableViewCell()
        case 1:
            if let graphCell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell{
             return graphCell
            }
            return UITableViewCell()
        default:
            if let childCountCell = tableView.dequeueReusableCell(withIdentifier: "ChildCountTableViewCell", for: indexPath) as? ChildCountTableViewCell{
             return childCountCell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 130
        case 1:
           return 130
        default:
           return 120
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 30
        case 2:
            return 60
        default:
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
            headerView.backgroundColor = self.view.backgroundColor
            return headerView
        case 1:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
            headerView.backgroundColor = self.view.backgroundColor
            return headerView
        case 2:
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = self.view.backgroundColor
        let label = UILabel()
        label.backgroundColor = tableView.backgroundColor
        label.frame = CGRect.init(x: 40, y: 10, width: headerView.frame.width-40, height: headerView.frame.height - 20 )
        if(self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue){
            label.text = "All States"
        }else {
            label.text = "All Countries"
        }
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // my custom font
        label.textColor = UIColor.white // my custom colour
        headerView.addSubview(label)
        return headerView

        default:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            headerView.backgroundColor = self.view.backgroundColor

            return headerView
        }
        
    }
 }

extension HomeViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if(self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue){
            
        }
    }
    
}
 
