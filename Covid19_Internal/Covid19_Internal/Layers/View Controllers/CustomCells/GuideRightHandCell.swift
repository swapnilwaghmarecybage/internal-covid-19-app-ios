//
//  GuideRightHandCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/16/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GuideRightHandCell: UITableViewCell {

    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var viewInner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String,imageName: String, description: String){
         
        if UIScreen.main.bounds.width > 350 {
            self.labelTitle.font = .boldSystemFont(ofSize: 18)
            self.labelDetails.font = .systemFont(ofSize: 16)
        } else {
            self.labelTitle.font = .boldSystemFont(ofSize: 16)
            self.labelDetails.font = .systemFont(ofSize: 14)
        }
        
            self.viewInner.layer.cornerRadius = 10
            self.viewInner.backgroundColor = Theme.highlightedColor

            self.imageInfo.layer.masksToBounds = true
            self.imageInfo.layer.borderWidth = 1.0
            self.imageInfo.layer.borderColor = UIColor.white.cgColor
            self.imageInfo.layer.cornerRadius = 5

            self.labelTitle.textColor = Theme.labelColor
           self.labelDetails.textColor = Theme.labelColor
           self.imageInfo.layer.cornerRadius = 5
           
           self.imageInfo.image = UIImage(named: imageName)
           self.labelTitle.text = title
           self.labelDetails.text = description
       }


}
