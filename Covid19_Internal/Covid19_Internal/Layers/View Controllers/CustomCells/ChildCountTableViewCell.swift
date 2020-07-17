//
//  ChildCountTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/19/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class ChildCountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelChildNameValue: UILabel!
    @IBOutlet weak var labelDeceasedValue: UILabel!
    @IBOutlet weak var labelRecoveredValue: UILabel!
    @IBOutlet weak var labelConfirmedValue: UILabel!
    @IBOutlet weak var imageViewFlag: UIImageView!
    @IBOutlet weak var imageViewWidthConstrain: NSLayoutConstraint!
    @IBOutlet weak var viewInnerChild: UIView!
    @IBOutlet weak var labelConfirmedTitle: UILabel!
    @IBOutlet weak var labelRecoveredTitle: UILabel!
    @IBOutlet weak var labelDeceasedTitle: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configureCell(objectReceived:Any, indexPath: IndexPath){
        
        if UIScreen.main.bounds.width > 350 {
            self.labelChildNameValue.font = .systemFont(ofSize: 17)
            self.labelConfirmedTitle.font = .systemFont(ofSize: 15)
            self.labelRecoveredTitle.font = .systemFont(ofSize: 15)
            self.labelDeceasedTitle.font = .systemFont(ofSize: 15)
            self.labelConfirmedValue.font = .systemFont(ofSize: 15)
            self.labelRecoveredValue.font = .systemFont(ofSize: 15)
            self.labelDeceasedValue.font = .systemFont(ofSize: 15)
            
        } else {
            self.labelChildNameValue.font = .systemFont(ofSize: 15)
            self.labelConfirmedTitle.font = .systemFont(ofSize: 13)
            self.labelRecoveredTitle.font = .systemFont(ofSize: 13)
            self.labelDeceasedTitle.font = .systemFont(ofSize: 13)
            self.labelConfirmedValue.font = .systemFont(ofSize: 13)
            self.labelRecoveredValue.font = .systemFont(ofSize: 13)
            self.labelDeceasedValue.font = .systemFont(ofSize: 13)
        }
        
        self.viewInnerChild.layer.cornerRadius = 10
        self.viewInnerChild.backgroundColor = Theme.highlightedColor
        if (objectReceived is CountryModel) {
        let object = objectReceived as! CountryModel
            self.labelChildNameValue.text = "\((object.countryName != nil) ? "\(object.countryName!)" : "--")"
            self.labelConfirmedValue.text = "\((object.totalCases != nil) ? "\(object.totalCases!)" : "--")"
            self.labelRecoveredValue.text = "\((object.totalRecovered != nil) ? "\(object.totalRecovered!)" : "--")"
            self.labelDeceasedValue.text = "\((object.totalDeaths != nil) ? "\(object.totalDeaths!)" : "--")"
            self.imageViewWidthConstrain.constant = 30
            self.imageViewFlag.layer.cornerRadius = 3.5
            if let flagString = object.countryDetails?.flag{
                self.imageViewFlag.imageFromServerURL(flagString, placeHolder: nil)
            }
        } else if objectReceived is IndiaHistoryModel.DayWiseData.Region {
            let object = objectReceived as! IndiaHistoryModel.DayWiseData.Region
            self.labelChildNameValue.text = "\((object.loc != nil) ? "\(object.loc!)" : "--")"
            self.labelConfirmedValue.text = "\((object.totalConfirmed != nil) ? "\(object.totalConfirmed!)" : "--")"
            self.labelRecoveredValue.text = "\((object.discharged != nil) ? "\(object.discharged!)" : "--")"
            self.labelDeceasedValue.text = "\((object.deaths != nil) ? "\(object.deaths!)" : "--")"
            self.imageViewFlag.image = nil
            self.imageViewWidthConstrain.constant = 0
        } else if (objectReceived is DistrictModel.District){
            let object = objectReceived as! DistrictModel.District
            self.labelChildNameValue.text = "\((object.districtName != nil) ? "\(object.districtName!)" : "--")"
            self.labelConfirmedValue.text = "\((object.confirmed != nil) ? "\(object.confirmed!)" : "--")"
            self.labelRecoveredValue.text = "\((object.recovered != nil) ? "\(object.recovered!)" : "--")"
            self.labelDeceasedValue.text = "\((object.deceased != nil) ? "\(object.deceased!)" : "--")"
        }
        else {
            self.labelChildNameValue.text = ""
            self.labelConfirmedValue.text = ""
            self.labelRecoveredValue.text = ""
            self.labelDeceasedValue.text = ""
           
        }
        
        self.labelConfirmedValue.textColor = BarColors.confirmedColor
        self.labelRecoveredValue.textColor = BarColors.recoveredColor
        self.labelDeceasedValue.textColor = BarColors.deceasedColor
    }
    
}
