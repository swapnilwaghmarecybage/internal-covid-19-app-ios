//
//  ResultTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/26/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMessage: UILabel!
    var delegate: SelfAssistanceManager?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: String){
        self.labelMessage.text = message
    }

    @IBAction func onClickOption(_ sender: UIButton) {
        delegate?.goBackCheckupDone()
    }

}
