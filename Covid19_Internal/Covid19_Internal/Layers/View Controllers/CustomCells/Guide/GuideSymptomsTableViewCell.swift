//
//  GuideSymptomsTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GuideSymptomsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewFever: UIImageView!
    @IBOutlet weak var imageViewDryCough: UIImageView!
    @IBOutlet weak var imageViewTiredness: UIImageView!
    @IBOutlet weak var labelLessCommonSymptoms: UILabel!
    
    @IBOutlet weak var viewStackViewParent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(){
        if UIScreen.main.bounds.width > 350 {
            self.labelLessCommonSymptoms.font = .systemFont(ofSize: 20)

        } else {
            self.labelLessCommonSymptoms.font = .systemFont(ofSize: 18)
        }

        
        self.viewStackViewParent.layer.cornerRadius = 10
        self.viewStackViewParent.backgroundColor = Theme.highlightedColor
        self.labelLessCommonSymptoms.text = Guide.lessCommonSymptoms
        imageViewFever.image = UIImage.gifImageWithName("light_fever")
        imageViewDryCough.image = UIImage.gifImageWithName("light_cough")
        imageViewTiredness.image = UIImage.gifImageWithName("light_tiredness")

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
