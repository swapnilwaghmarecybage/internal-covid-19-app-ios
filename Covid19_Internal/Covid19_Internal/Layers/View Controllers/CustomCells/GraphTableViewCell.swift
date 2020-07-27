//
//  GraphTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/19/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {

    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var barChartViewContainer: UIView!
    @IBOutlet weak var radioButtonsContainer: UIView!
    private var radioButtonView:RadioButtonView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let views = Bundle.main.loadNibNamed("RadioControlView", owner: nil, options: nil)
               
        self.radioButtonView = views?[1] as? RadioButtonView

    }

    func configureCell(objectReceived:Any) {
        self.pieChartView.layer.cornerRadius = 10
        self.barChartViewContainer.layer.cornerRadius = 10
        self.pieChartView.backgroundColor = Theme.highlightedColor
        self.barChartViewContainer.backgroundColor = Theme.highlightedColor

        if(objectReceived is PieChartDataType) {
            let object = objectReceived as! PieChartDataType
            if (object.0.count == 0){
                return
            }
            self.barChartViewContainer.isHidden = true
            self.pieChartView.isHidden = false
            ChartsLayer.setPieChart(labels: object.0, values: object.1, inputView: self.pieChartView, shouldShowPercentage: object.shouldShowPercentage)
            
        }
        if (objectReceived is BarGraphDataType){
            let object = objectReceived as! BarGraphDataType
            if (object.labels.count == 0){
                return
            }
            self.barChartViewContainer.isHidden = false
            self.pieChartView.isHidden = true
            
            if self.radioButtonsContainer.subviews.filter({ (subview) -> Bool in
                if subview.tag == 999{
                    return true
                }
                return false
                }).count > 0 {
                return
            }
                   
            if let radioButtonView = self.radioButtonView {
                radioButtonView.configure(_barGraphDetails: object)
                
                radioButtonView.showDeceased = {
                    (_ labels: [String], _ deceased: [Double], barColor: UIColor, barName: String, barTag: Int) in
                    ChartsLayer.setBarChart(labels: labels, values: deceased, inputView: self.barChartView, barColor: barColor,barName: barName, barTag: barTag)
                }
                
                radioButtonView.showActive = {
                    (_ labels: [String], _ active: [Double], barColor: UIColor, barName: String, barTag: Int) in
                    ChartsLayer.setBarChart(labels: labels, values: active, inputView: self.barChartView, barColor: barColor,barName: barName, barTag:barTag)

                }
                
                radioButtonView.showConfirmed = {
                    (_ labels: [String], _ confirmed: [Double], barColor: UIColor, barName: String, barTag: Int) in
                    ChartsLayer.setBarChart(labels: labels, values: confirmed, inputView: self.barChartView, barColor: barColor,barName: barName,barTag:barTag)
                }
                
                radioButtonView.showRecovered = {
                    (_ labels: [String], _ recovered: [Double], barColor: UIColor, barName: String, barTag: Int) in
                    ChartsLayer.setBarChart(labels: labels, values: recovered, inputView: self.barChartView, barColor: barColor,barName: barName, barTag:barTag)
                }
                radioButtonView.showDefaultGraphofConfirmed()
                radioButtonView.frame.size = self.radioButtonsContainer.frame.size
                self.radioButtonsContainer.addSubview(radioButtonView)

            }
                 
        }
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutIfNeeded() {
        self.radioButtonView?.frame.size = self.radioButtonsContainer.frame.size
    }
    
    
}

