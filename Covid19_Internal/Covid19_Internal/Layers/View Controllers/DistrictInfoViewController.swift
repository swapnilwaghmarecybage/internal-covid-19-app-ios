//
//  DIstrictInfoViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class DistrictInfoViewController: BaseViewController {
    
    @IBOutlet weak var labelStateName: UILabel!
    @IBOutlet weak var tableViewDistrictData: UITableView!

    
    var stateData: IndiaHistoryModel.DayWiseData.Region?
    var stateHistoryData: [IndiaHistoryModel.DayWiseData.Region]?
    var viewModelDistrict: DistrictViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.backgroundColor
        
        updateNavigationBar()

        viewModelDistrict = DistrictViewModel(_statedata: self.stateData, _stateHistoryData: self.stateHistoryData,
                                              completion:{ (success) in
            if(success){
                DispatchQueue.main.async {
                    self.tableViewDistrictData.reloadData()
                }
            }
        })
        

        viewModelDistrict?.getAllDistrictsData(completion: { (success) in
            if(success){
                DispatchQueue.main.async {
                    self.tableViewDistrictData.reloadData()
                }
            }
        })
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: NetworkReceivedNotification,
                                               object: nil)

        self.labelStateName.text = self.stateData?.loc ?? "--"
    }
    
    @objc func reachabilityChanged(notification: Notification) {
       
        if(notification.name == NetworkReceivedNotification){
            if(viewModelDistrict?.getDistrictCount() == 0){
                viewModelDistrict?.getAllDistrictsData(completion: { (success) in
                    if(success){
                        DispatchQueue.main.async {
                            self.tableViewDistrictData.reloadData()
                        }
                    }
                })
            }
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NetworkReceivedNotification, object: nil)
    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "State Details"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DistrictInfoViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let _viewModel = self.viewModelDistrict {
        switch indexPath.section {
              case 0:
               
               if let graphCell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell{
                       graphCell.configureCell(objectReceived: _viewModel.getPieChartDataForState())
                          return graphCell
                         }
                         return UITableViewCell()
               
               case 1:
                  if let graphCell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell{
                       graphCell.configureCell(objectReceived: _viewModel.getBarChartDataForState())
                       return graphCell
                  }
                  return UITableViewCell()
              default:
                  if let childCountCell = tableView.dequeueReusableCell(withIdentifier: "ChildCountTableViewCell", for: indexPath) as? ChildCountTableViewCell,
                    let objectReceived = _viewModel.getDistrictAtIndex(index: indexPath){
                       childCountCell.configureCell(objectReceived: objectReceived, indexPath: indexPath)
                        return childCountCell
                  }
                  return UITableViewCell()
              }
    }
    return UITableViewCell()
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       if let viewModel = self.viewModelDistrict{
        return viewModel.numberOfRowsAtIndexPath(section: section)
        }
    return 0
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       switch indexPath.section {
       case 0 :
           return 250
       case 1:
          return 250
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
           return 0
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
       label.text = "All Districts"
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

extension DistrictInfoViewController: UITableViewDelegate {
    
}
