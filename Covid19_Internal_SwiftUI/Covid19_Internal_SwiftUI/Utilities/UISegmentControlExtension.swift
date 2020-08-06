//
//  UISegmentControlExtension.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/19/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
extension UISegmentedControl {
    
    func addBorder(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat){
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func updateTextColor() {
        let selectedTextAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight:.semibold),
                                     NSAttributedString.Key.foregroundColor: Theme.selectedSegmentControlColor]
        let normalTextAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0),
                                   NSAttributedString.Key.foregroundColor: Theme.unSelectedSegmentControlColor]

        self.setTitleTextAttributes(selectedTextAttribute, for: .selected)
        self.setTitleTextAttributes(normalTextAttribute, for: .normal)
    }
    
}
