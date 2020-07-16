//
//  GuideViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/16/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GuideViewController: BaseViewController {

    @IBOutlet weak var tableViewGuide: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.backgroundColor
       // self.tableViewGuide.backgroundColor = Theme.backgroundColor
        tableViewGuide.separatorColor = Theme.labelColor
    }

}

extension GuideViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Guide.Dos.count
        case 1:
            return Guide.Donts.count
        case 2:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row % 2 == 0{
                if let rightCell = tableView.dequeueReusableCell(withIdentifier: "GuideRightHandCell") as? GuideRightHandCell{
                    rightCell.configureCell(title: Guide.Dos[indexPath.row].title, imageName: Guide.Dos[indexPath.row].imageName, description: Guide.Dos[indexPath.row].description)
                    return rightCell
                }
            } else {
                if let leftCell = tableView.dequeueReusableCell(withIdentifier: "GuideLeftHandCell") as? GuideLeftHandCell{
                   leftCell.configureCell(title: Guide.Dos[indexPath.row].title, imageName: Guide.Dos[indexPath.row].imageName, description: Guide.Dos[indexPath.row].description)
                    return leftCell
                }
            }
        case 1:
            if indexPath.row % 2 == 0{
                if let rightCell = tableView.dequeueReusableCell(withIdentifier: "GuideRightHandCell") as? GuideRightHandCell{
                   rightCell.configureCell(title: Guide.Donts[indexPath.row].title, imageName: Guide.Donts[indexPath.row].imageName, description: Guide.Donts[indexPath.row].description)
                    return rightCell
                }
                
            } else {
                if let leftCell = tableView.dequeueReusableCell(withIdentifier: "GuideLeftHandCell") as? GuideLeftHandCell{
                   leftCell.configureCell(title: Guide.Donts[indexPath.row].title, imageName: Guide.Donts[indexPath.row].imageName, description: Guide.Donts[indexPath.row].description)
                    return leftCell
                }
                
            }
        case 2:
            return UITableViewCell()
        default:
            return UITableViewCell()
            
        }
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
            headerView.backgroundColor = BarColors.recoveredColor
            let label = UILabel()
            label.backgroundColor = tableView.backgroundColor
            label.frame = headerView.frame
            label.text = "Do's"
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // my custom font
            label.textColor = Theme.labelColor // my custom colour
            label.textAlignment = .center
            headerView.addSubview(label)
            return headerView
        case 1:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
            headerView.backgroundColor = BarColors.activeColor
            let label = UILabel()
            label.backgroundColor = tableView.backgroundColor
            label.frame = headerView.frame
            label.text = "Don'ts"
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // my custom font
            label.textColor = Theme.labelColor // my custom colour
            label.textAlignment = .center
            headerView.addSubview(label)
            return headerView
        case 2:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
            headerView.backgroundColor = BarColors.confirmedColor
            let label = UILabel()
            label.backgroundColor = tableView.backgroundColor
            label.frame = headerView.frame
            label.text = "Guidelines"
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // my custom font
            label.textColor = Theme.labelColor // my custom colour
            label.textAlignment = .center
            headerView.addSubview(label)
            return headerView
            
        default:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            headerView.backgroundColor = self.view.backgroundColor
            return headerView
        }
     }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        case 1:
            return 60
        case 2:
            return 60
        default:
           return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 175
        case 1:
            return  175 //self.dataSelectionSegmentControl.selectedSegmentIndex == SegmentSelectionIndex.India.rawValue ? 250 : 250
        default:
           return 175
        }
    }

    
}

extension GuideViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
