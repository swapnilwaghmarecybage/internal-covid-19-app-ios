//
//  ChartsLayer.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/25/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import Charts

struct ChartsLayer {
    
    static func setPieChart(labels: [String], values: [Double], inputView: UIView) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: labels[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let pieChartView = PieChartView(frame: inputView.frame)
        pieChartView.data = pieChartData
        
        pieChartDataSet.colors = [UIColor.red, UIColor.green, UIColor.blue]
        inputView.addSubview(pieChartView)
        
    }
}
