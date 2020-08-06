//
//  TabViewParent.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct TabViewParent: View {
    
    @State  var selection = 0
    init() {}
    
    var body: some View {
        
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image("home").renderingMode(.template)
                    Text("Home")
            }.tag(0)
            GuideView()
                .tabItem{
                    Image("guide").renderingMode(.template)
                    Text("Guide")
            }.tag(1)
        }.accentColor(Color(Theme.tabselectedColor))
    }
}
