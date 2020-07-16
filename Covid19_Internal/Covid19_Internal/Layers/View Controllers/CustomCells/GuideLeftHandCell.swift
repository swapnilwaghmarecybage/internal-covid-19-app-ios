//
//  GuideLeftHandCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/16/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GuideLeftHandCell: UITableViewCell {

        @IBOutlet weak var imageInfo: UIImageView!
        @IBOutlet weak var labelTitle: UILabel!
        @IBOutlet weak var labelDetails: UILabel!
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

       }
       
       func configureCell(title: String,imageName: String, description: String){
          
           self.contentView.backgroundColor = Theme.backgroundColor
           self.labelTitle.textColor = Theme.labelColor
           self.labelDetails.textColor = Theme.labelColor
           self.imageInfo.layer.cornerRadius = 5
           
           self.imageInfo.image = UIImage(named: imageName)
           self.labelTitle.text = title
           self.labelDetails.text = description
       }

}
