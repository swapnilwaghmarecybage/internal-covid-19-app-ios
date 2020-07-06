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
        
        if(inputView.subviews.count == 0){
            var dataEntries: [PieChartDataEntry] = []
            
            for i in 0..<values.count {
                let dataEntry = PieChartDataEntry(value: values[i], label: labels[i])
                dataEntries.append(dataEntry)
            }
            
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
          //  pieChartDataSet.selectionShift = 0
            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            let pieChartView = PieChartView(frame: inputView.frame)
            pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOptionX: .easeInCirc, easingOptionY: .easeInCirc)
            pieChartView.data = pieChartData
            pieChartView.holeColor = UIColor.clear
            //pieChartView.legend.form = .none
            pieChartView.legend.enabled = false
            pieChartView.chartDescription?.enabled = false
            pieChartView.frame.origin = CGPoint.zero
            pieChartView.frame.size = inputView.frame.size
            pieChartDataSet.colors = [UIColor(red: 205/255, green: 92/255, blue: 92/255, alpha: 1.0),
                                      UIColor(red: 60/255, green: 179/255, blue: 113/255, alpha: 1.0),
                                      UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1.0)]
            inputView.addSubview(pieChartView)
            
            pieChartView.translatesAutoresizingMaskIntoConstraints = false

            inputView.addConstraint(NSLayoutConstraint(item: pieChartView, attribute: .trailing, relatedBy: .equal, toItem: inputView, attribute: .trailing, multiplier: 1, constant: 0))
            inputView.addConstraint(NSLayoutConstraint(item: pieChartView, attribute: .leading, relatedBy: .equal, toItem: inputView, attribute: .leading, multiplier: 1, constant: 0))
            inputView.addConstraint(NSLayoutConstraint(item: pieChartView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1, constant: 0))
            inputView.addConstraint(NSLayoutConstraint(item: pieChartView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0))
        }
    }
    
    static func setBarChart(labels: [String], values: [Double], inputView: UIView){
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry =  BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        let chartData = BarChartData(dataSet: chartDataSet)
        let barChartView = BarChartView(frame: inputView.frame)
        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        barChartView.legend.enabled = false
        barChartView.chartDescription?.enabled = false
        barChartView.frame.origin = CGPoint.zero
        barChartView.frame.size = inputView.frame.size
        chartDataSet.colors = [UIColor(red: 205/255, green: 92/255, blue: 92/255, alpha: 1.0)]
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        inputView.addSubview(barChartView)
        
        barChartView.translatesAutoresizingMaskIntoConstraints = false

        inputView.addConstraint(NSLayoutConstraint(item: barChartView, attribute: .trailing, relatedBy: .equal, toItem: inputView, attribute: .trailing, multiplier: 1, constant: 0))
        inputView.addConstraint(NSLayoutConstraint(item: barChartView, attribute: .leading, relatedBy: .equal, toItem: inputView, attribute: .leading, multiplier: 1, constant: 0))
        inputView.addConstraint(NSLayoutConstraint(item: barChartView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1, constant: 0))
        inputView.addConstraint(NSLayoutConstraint(item: barChartView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0))
        
    }
    
    
    static func setLineChart(labels: [String], values: [Double], inputView: UIView){
           var dataEntries: [ChartDataEntry] = []
           
           for i in 0..<values.count {
               let dataEntry =  ChartDataEntry(x: Double(i), y: values[i])
               dataEntries.append(dataEntry)
           }
           
           let chartDataSet = LineChartDataSet(entries: dataEntries)
           let chartData = LineChartData(dataSet: chartDataSet)
           let lineChartView = LineChartView(frame: inputView.frame)
           lineChartView.data = chartData
           lineChartView.legend.enabled = false
           lineChartView.chartDescription?.enabled = false
           lineChartView.frame.origin = CGPoint.zero
           lineChartView.frame.size = inputView.frame.size
           chartDataSet.colors = [UIColor(red: 205/255, green: 92/255, blue: 92/255, alpha: 1.0)]
           lineChartView.xAxis.labelPosition = .bottom
           lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
           inputView.addSubview(lineChartView)
           
           lineChartView.translatesAutoresizingMaskIntoConstraints = false

           inputView.addConstraint(NSLayoutConstraint(item: lineChartView, attribute: .trailing, relatedBy: .equal, toItem: inputView, attribute: .trailing, multiplier: 1, constant: 0))
           inputView.addConstraint(NSLayoutConstraint(item: lineChartView, attribute: .leading, relatedBy: .equal, toItem: inputView, attribute: .leading, multiplier: 1, constant: 0))
           inputView.addConstraint(NSLayoutConstraint(item: lineChartView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1, constant: 0))
           inputView.addConstraint(NSLayoutConstraint(item: lineChartView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0))
           
       }
}
