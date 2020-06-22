//
//  TotalCountTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/19/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class TotalCountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelConfirmedCasesValue: UILabel!
    @IBOutlet weak var labelRecoveredValue: UILabel!
    @IBOutlet weak var labelDeathsValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(object: CountryModel) {
        self.labelConfirmedCasesValue.text =  "\((object.totalCases != nil) ? "\(object.totalCases!)" : "--")   (+\((object.newCases != nil) ? "\(object.newCases!)" : "--"))"
        self.labelRecoveredValue.text = "\((object.totalRecovered != nil) ? "\(object.totalRecovered!)" : "--")   (+\((object.newRecovered != nil) ? "\(object.newRecovered!)" : "--"))"
        self.labelDeathsValue.text = "\((object.totalDeaths != nil) ? "\(object.totalDeaths!)" : "--")   (+\((object.newDeaths != nil) ? "\(object.newDeaths!)" : "--"))"
    }

}
