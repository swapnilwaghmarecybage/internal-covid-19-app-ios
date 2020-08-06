//
//  GraphCell.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct GraphCell: View {
    
    init(_chartDataTpe: Any) {
        chartDataTpe = _chartDataTpe
        UITableViewCell.appearance().backgroundColor = .clear

    }
    
    var chartDataTpe: Any
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    private var heightOfContainer: CGFloat = 250

    var body: some View {
        Group{
            VStack{
                if (chartDataTpe is PieChartDataType){
                    PieChartContainer(_data: chartDataTpe as! PieChartDataType)
                } else {
                    BarChartContainer(_data: chartDataTpe as! BarGraphDataType)
                }
            }.frame(width:  screenWidth - 50, height: heightOfContainer)
                .background(Color(Theme.highlightedColor))
                .position(x: (UIScreen.main.bounds.width/2)-25, y: heightOfContainer/2)
                .background(Color(Theme.highlightedColor))
                .cornerRadius(10)
                .padding(.top, CGFloat(5))
                .padding(.bottom, CGFloat(5))
        }.padding(.leading, CGFloat(10))
        .padding(.trailing, CGFloat(10))
    }
}
