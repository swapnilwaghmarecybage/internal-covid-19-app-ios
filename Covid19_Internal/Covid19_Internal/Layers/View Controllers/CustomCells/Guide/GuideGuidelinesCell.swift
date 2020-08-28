//
//  GuideGuidelinesCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/27/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GuideGuidelinesCell: UITableViewCell {

    @IBOutlet weak var labelGuidelines: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(){
        if UIScreen.main.bounds.width > 350 {
            self.labelGuidelines.font = .systemFont(ofSize: 20)

        } else {
            self.labelGuidelines.font = .systemFont(ofSize: 18)
        }

        labelGuidelines.text = Guide.psychologicalGuidelines
    }

}
