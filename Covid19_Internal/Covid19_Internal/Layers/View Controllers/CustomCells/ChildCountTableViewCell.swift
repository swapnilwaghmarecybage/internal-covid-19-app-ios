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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(objectReceived:Any, indexPath: IndexPath){
        if (objectReceived is CountryModel){
        let object = objectReceived as! CountryModel
            self.labelChildNameValue.text = "\((object.countryName != nil) ? "\(object.countryName!)" : "--")"
            self.labelConfirmedValue.text = "\((object.totalCases != nil) ? "\(object.totalCases!)" : "--")"
            self.labelRecoveredValue.text = "\((object.totalRecovered != nil) ? "\(object.totalRecovered!)" : "--")"
            self.labelDeceasedValue.text = "\((object.totalDeaths != nil) ? "\(object.totalDeaths!)" : "--")"
            if let flagString = object.countryDetails?.flag{
                self.imageViewFlag.imageFromServerURL(flagString, placeHolder: nil)
            }
            /*
                if self.tag == indexPath.row {
                    if let flagString = object.countryDetails?.flag, let url = URL(string: flagString){
                        do {
                           let data =  try Data(contentsOf: url)
                            DispatchQueue.main.async {
                                self.imageViewFlag.image =  UIImage(data:data )
                            }
                        }catch{
                            print("failed to load image")
                        }
                    }
                }
            */
        }
    }
    
}
