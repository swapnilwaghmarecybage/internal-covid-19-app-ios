//
//  HomeViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    private var viewModelHomeTab:HomeTabViewModel?
    
    @IBOutlet weak var dataSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewCovidData: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.backgroundColor
        dataSelectionSegmentControl.addBorder(borderWidth: 1.0, borderColor: Theme.labelColor, cornerRadius: 0.5)
        if #available(iOS 13.0, *) {
            dataSelectionSegmentControl.selectedSegmentTintColor = Theme.highlightedColor
        } else {
            // Fallback on earlier versions
            dataSelectionSegmentControl.tintColor = Theme.highlightedColor
        }
        dataSelectionSegmentControl.backgroundColor = Theme.backgroundColor
        dataSelectionSegmentControl.updateTextColor()
        
        viewModelHomeTab = HomeTabViewModel();
        viewModelHomeTab?.getCountriesData(completion: { (success) in
            if(success){
            // refresh tableview
                DispatchQueue.main.async {
                    self.tableViewCovidData.reloadData()
                }
            }
        })
        viewModelHomeTab?.getIndiaHistoricalData(completion: { (success) in
            DispatchQueue.main.async {
                self.tableViewCovidData.reloadData()
            }
        })
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: NetworkReceivedNotification,
                                               object: nil)

    }
    
    
    @IBAction func onClickSegmentControlOption(_ sender: UISegmentedControl) {
        tableViewCovidData.reloadData()
        let indexPath = NSIndexPath(row: 0, section: 0)
        tableViewCovidData.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)

    }
    
    
    @objc func reachabilityChanged(notification: Notification) {
        if (notification.name == NetworkReceivedNotification){
            
            if(viewModelHomeTab?.getCountriesCount() == 0){
                viewModelHomeTab?.getCountriesData(completion: { (success) in
                    if(success){
                    // refresh tableview
                        DispatchQueue.main.async {
                            self.tableViewCovidData.reloadData()
                        }
                    }
                })
            }
            
            if(viewModelHomeTab?.getStatesCount() == 0){
                viewModelHomeTab?.getIndiaHistoricalData(completion: { (success) in
                    DispatchQueue.main.async {
                        self.tableViewCovidData.reloadData()
                    }
                })

            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NetworkReceivedNotification, object: nil)
    }

}
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let parentCountCell = tableView.dequeueReusableCell(withIdentifier: "TotalCountTableViewCell", for: indexPath) as? TotalCountTableViewCell{
                if let viewModel = self.viewModelHomeTab {
                    if let countryModelObject =  self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? viewModel.getIndiaObject():viewModel.getWorldObjcect(){
                        parentCountCell.configureCell(objectReceived: countryModelObject)
                    }
                }
                return parentCountCell
            }
            return UITableViewCell()
        case 1:
            if let graphCell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell{
                
                if let viewModel = self.viewModelHomeTab,
                    let countryModelObject:Any =  self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? viewModel.getDataForIndiaBarChart() : viewModel.getDataForWorldPieChart(){
                    graphCell.configureCell(objectReceived: countryModelObject)
                
                }
                return graphCell
            }
            return UITableViewCell()
        default:
            if let childCountCell = tableView.dequeueReusableCell(withIdentifier: "ChildCountTableViewCell", for: indexPath) as? ChildCountTableViewCell{
                if let viewModel = self.viewModelHomeTab,
                    let countryModelObject =  self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? viewModel.getStateAtIndex(index: indexPath) : viewModel.getCountryAtIndex(index: indexPath){
                    childCountCell.tag = indexPath.row
                    childCountCell.configureCell(objectReceived: countryModelObject, indexPath: indexPath)
                }
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
            if let viewModel = self.viewModelHomeTab {
                return  self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? viewModel.getStatesCount() : viewModel.getCountriesCount()
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 130
        case 1:
            return  250 //self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? 250 : 250
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
        label.textColor = Theme.labelColor // my custom colour
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
        if(self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue && indexPath.section == 2){
            if let districtVC =  self.storyboard?.instantiateViewController(withIdentifier: "DistrictInfoViewController") as? DistrictInfoViewController {
                
                districtVC.stateData = self.viewModelHomeTab?.getStateAtIndex(index: indexPath) as? IndiaHistoryModel.DayWiseData.Region
                districtVC.stateHistoryData =  self.viewModelHomeTab?.getDataForStateHistoryBarChart(_stateName: districtVC.stateData?.loc)
                self.navigationController?.pushViewController(districtVC, animated: true)
            }
        }
    }
    
}
 
