//
//  PaddedLabel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 9/6/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit



class PaddedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
}
