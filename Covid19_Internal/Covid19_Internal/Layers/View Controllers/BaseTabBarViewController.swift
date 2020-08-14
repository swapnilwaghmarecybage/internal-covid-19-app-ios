//
//  BaseTabBarViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let outlineColor = Theme.outlineColor
        self.tabBar.addTopBorderLayer(borderWidth: 0.5, borderColor: outlineColor)
        self.tabBar.addSeparatorBetweenTabBarItems(separatorWidth: 0.5, separatorColor: outlineColor)
        self.tabBar.barTintColor = Theme.tabBarBackgroundColor
        self.tabBar.unselectedItemTintColor = Theme.tabUnselectedColor
        self.tabBar.tintColor = Theme.tabselectedColor
        //self.tabBar.updateTabBarTitlesAttributes()
        
        
    }
}
    
   



