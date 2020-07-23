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
    
    func createHeaderView(viewBackgroundColor: UIColor, labelBackgroundColor: UIColor, labelTextColor: UIColor, viewWidth: CGFloat, viewHeight:CGFloat, labelText: String) -> UIView{
        let headerView = UIView.init(frame: CGRect.init(x: 10, y: 0, width: viewWidth , height: viewHeight))
        headerView.backgroundColor = viewBackgroundColor
        let labelLine = UILabel()
        labelLine.backgroundColor = labelBackgroundColor
        labelLine.frame = CGRect(x: 10, y: (viewHeight/2)-1, width: viewWidth , height: 2)
        headerView.addSubview(labelLine)

        let labelTitle = UILabel()
        labelTitle.backgroundColor = labelBackgroundColor
        labelTitle.frame = CGRect(x: (viewWidth/2) - 50, y: 5, width: 100, height: viewHeight - 10)
        labelTitle.text = labelText
        labelTitle.font = UIFont.systemFont(ofSize: 17, weight: .bold) // my custom font
        labelTitle.textColor = labelTextColor // my custom colour
        labelTitle.textAlignment = .center
        headerView.addSubview(labelTitle)
        return headerView
    }
    
    
    func heightForRowFor(array:[Dos_And_Donts], indexPath: IndexPath) -> CGFloat {
        
        let labelWidth = tableViewGuide.frame.width * (250/414)
            var fontSizeTitle:CGFloat = 18.0
            var fontSizeDescription:CGFloat = 16.0
            if UIScreen.main.bounds.width < 350 {
                fontSizeTitle = 16.0
                fontSizeDescription = 14.0
            }

        let constraintRectTitle = CGSize(width: labelWidth, height: 40)
        let boundingBoxTitle = array[indexPath.row].title.boundingRect(with: constraintRectTitle, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:fontSizeTitle)], context: nil)
        let constraintRectDescription = CGSize(width: labelWidth, height: 100)
        let boundingBoxDescription = array[indexPath.row].description.boundingRect(with: constraintRectDescription, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSizeDescription)], context: nil)
        return boundingBoxTitle.height + boundingBoxDescription.height + 100
    }

}

extension GuideViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Guide.Dos.count
        case 2:
            return Guide.Donts.count
        case 3:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let symptomsCell  = tableView.dequeueReusableCell(withIdentifier: "GuideSymptomsTableViewCell") as? GuideSymptomsTableViewCell {
                symptomsCell.configureCell()
                return symptomsCell;
            }
            return UITableViewCell()
        case 1:
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
        case 2:
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
        case 3:
            return UITableViewCell()
        default:
            return UITableViewCell()
            
        }
        return UITableViewCell()
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
           return self.createHeaderView(viewBackgroundColor: Theme.backgroundColor,
                                  labelBackgroundColor: BarColors.recoveredColor,
                                  labelTextColor: Theme.labelColor,
                                  viewWidth: tableView.frame.width - 20,
                                  viewHeight: 50,
                                  labelText: "DO'S")
        case 2:
            return self.createHeaderView(viewBackgroundColor: Theme.backgroundColor,
                                   labelBackgroundColor: BarColors.activeColor,
                                   labelTextColor: Theme.labelColor,
                                   viewWidth: tableView.frame.width - 20,
                                   viewHeight: 50,
                                   labelText: "DON'TS")

        case 3:
            return self.createHeaderView(viewBackgroundColor: Theme.backgroundColor,
                                   labelBackgroundColor: BarColors.confirmedColor,
                                   labelTextColor: Theme.labelColor,
                                   viewWidth: tableView.frame.width - 20,
                                   viewHeight: 50,
                                   labelText: "GUIDELINES")

        default:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
            headerView.backgroundColor = self.view.backgroundColor
            return headerView
        }
     }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 50
        default:
           return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 440
        case 1 :
            return self.heightForRowFor(array: Guide.Dos, indexPath: indexPath)
        case 2:
            return self.heightForRowFor(array: Guide.Donts, indexPath: indexPath)
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
