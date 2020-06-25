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

    func configureCell(objectReceived:Any) {
        if(objectReceived is IndiaHistoryModel.DayWiseData.Region){
           let object = objectReceived as! IndiaHistoryModel.DayWiseData.Region
            
            if let deaths = object.deaths, let recovered = object.discharged, let confirmed = object.totalConfirmed{
                let labels = ["Deaths","Recovered", "Acive"]
                let values = [Double(deaths),Double(recovered),Double(confirmed - recovered)]
                ChartsLayer.setPieChart(labels: labels, values: values, inputView: self.graphView)
            }
            
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
