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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(objectReceived:Any) {
        
        if(objectReceived is PieChartDataType) {
            let object = objectReceived as! PieChartDataType
            self.barChartView.isHidden = true
            self.pieChartView.isHidden = false
            ChartsLayer.setPieChart(labels: object.0, values: object.1, inputView: self.pieChartView)
            
        }
        if (objectReceived is BarGraphDataType){
            let object = objectReceived as! BarGraphDataType
            self.barChartView.isHidden = false
            self.pieChartView.isHidden = true

            ChartsLayer.setBarChart(labels: object.0, values: object.1, inputView: self.barChartView)
        }
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
