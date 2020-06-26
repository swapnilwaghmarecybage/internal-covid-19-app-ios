//
//  GraphTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/19/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {

    @IBOutlet weak var graphView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(objectReceived:Any, chartType:CharType) {
        if(objectReceived is IndiaHistoryModel.DayWiseData.Region){
           let object = objectReceived as! IndiaHistoryModel.DayWiseData.Region
            if(chartType == .Pie){
                if let deaths = object.deaths, let recovered = object.discharged, let confirmed = object.totalConfirmed{
                    let labels = ["Deaths","Recovered", "Acive"]
                    let values = [Double(deaths),Double(recovered),Double(confirmed - recovered)]
                    ChartsLayer.setPieChart(labels: labels, values: values, inputView: self.graphView)
                }
            }
        } else if(objectReceived is CountryModel) {
           let object = objectReceived as! CountryModel
            if(chartType == .Pie){
                self.graphView.subviews.forEach({ $0.removeFromSuperview() })

                if let deaths = object.totalDeaths, let recovered = object.totalRecovered, let active = object.totalActive{
                    let labels = ["Deaths","Recovered", "Acive"]
                    let values = [Double(deaths),Double(recovered),Double(active)]
                    ChartsLayer.setPieChart(labels: labels, values: values, inputView: self.graphView)
                }
            } else {
                self.graphView.subviews.forEach({ $0.removeFromSuperview() })
                
            }
        } else if (objectReceived is ([String], [Double], [Double], [Double], [Double])){
            if(chartType == .Bar){
                self.graphView.subviews.forEach({ $0.removeFromSuperview() })
                 let object = objectReceived as! ([String], [Double], [Double], [Double], [Double])
                ChartsLayer.setBarChart(labels: object.0, values: object.1, inputView: self.graphView)
            }
            
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
