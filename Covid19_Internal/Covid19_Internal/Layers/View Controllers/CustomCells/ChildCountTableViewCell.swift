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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(objectReceived:Any, indexPath: IndexPath){
        if (objectReceived is CountryModel) {
        let object = objectReceived as! CountryModel
            self.labelChildNameValue.text = "\((object.countryName != nil) ? "\(object.countryName!)" : "--")"
            self.labelConfirmedValue.text = "\((object.totalCases != nil) ? "\(object.totalCases!)" : "--")"
            self.labelRecoveredValue.text = "\((object.totalRecovered != nil) ? "\(object.totalRecovered!)" : "--")"
            self.labelDeceasedValue.text = "\((object.totalDeaths != nil) ? "\(object.totalDeaths!)" : "--")"
            self.imageViewWidthConstrain.constant = 30
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
        } else {
            self.labelChildNameValue.text = ""
            self.labelConfirmedValue.text = ""
            self.labelRecoveredValue.text = ""
            self.labelDeceasedValue.text = ""
            self.imageViewFlag.image = nil
            self.imageViewWidthConstrain.constant = 0
        }
    }
    
}
