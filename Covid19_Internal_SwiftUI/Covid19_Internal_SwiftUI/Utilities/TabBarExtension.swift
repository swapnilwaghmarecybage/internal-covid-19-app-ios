//
//  TabBarExtension.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/18/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
    
    func addSeparatorBetweenTabBarItems(separatorWidth:CGFloat, separatorColor:UIColor){
        let itemWidth = floor(self.frame.size.width / CGFloat(self.items!.count))
        for i in 0...(self.items!.count - 1) {
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: 0, width: CGFloat(separatorWidth), height: self.frame.size.height))
            separator.backgroundColor = separatorColor
            self.addSubview(separator)
        }
    }
    
    func addTopBorderLayer(borderWidth:CGFloat, borderColor:UIColor){
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: 0,y: 0, width: self.frame.size.width, height:borderWidth)
        self.layer.addSublayer(border)

    }
    
     func updateTabBarTitlesAttributes() {
        if let items = self.items{
            for item in items{
                let selectedTabTitleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight:.heavy),
                                                 NSAttributedString.Key.foregroundColor: Theme.labelColor]
                    item.setTitleTextAttributes(selectedTabTitleAttribute, for: .selected)
                    let normalTabTitleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0),
                                                   NSAttributedString.Key.foregroundColor: Theme.tabUnselectedColor]
                    item.setTitleTextAttributes(normalTabTitleAttribute, for: .normal)
                
            }
        }
    }
    
    
}
