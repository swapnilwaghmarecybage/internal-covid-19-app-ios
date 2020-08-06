//
//  BarChartView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct BarChartContainer: View {
    
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    private var data: BarGraphDataType
    @State private var selectionIndex = 0
    
    init(_data:BarGraphDataType) {
        self.data = _data
    }
    
    var body: some View {
        VStack{
            BarChart(containerFrame: CGRect(x: 0, y: 0, width: screenWidth - 50, height: 215),
                     _barChartData:data, selectionIndex: $selectionIndex)
            .padding(.trailing,CGFloat(10))

            BarChartControls(selectionIndex: $selectionIndex)
        }
        .background(Color.clear)
        .padding(.bottom, CGFloat(5))
    }
}

fileprivate struct BarChart: UIViewRepresentable {
    var containerFrame: CGRect
    var _barChartData: BarGraphDataType
    @Binding var selectionIndex: Int
    
    func makeUIView(context: Context) -> UIView {
        
       
        let chart = UIView(frame: containerFrame)
        chart.tag = 101
        chart.backgroundColor = UIColor.clear
        
        ChartsLayer.setBarChart(labels: _barChartData.labels,
                                values: _barChartData.valuesOfTotalConfirmed,
                                inputView: chart,
                                barColor: BarColors.confirmedColor,
                                barName: BarName.confirmed.rawValue,
                                barTag: 0)
 
        return chart
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if(uiView.tag != 101){
            return
        }
        var values = [Double]()
        var barColor =  BarColors.confirmedColor
        var barName = BarName.confirmed.rawValue
               if(self.selectionIndex == 0){
                   values = _barChartData.valuesOfTotalConfirmed
                    barColor =  BarColors.confirmedColor
                    barName = BarName.confirmed.rawValue
               }
               if(self.selectionIndex == 1){
                   values = _barChartData.valueOfTotalActive
                    barColor =  BarColors.activeColor
                    barName = BarName.active.rawValue
               }
               if(self.selectionIndex == 2){
                   values = _barChartData.valueOfTotalRecovered
                    barColor =  BarColors.recoveredColor
                    barName = BarName.receovered.rawValue
               }
               if (self.selectionIndex == 3){
                   values = _barChartData.valueOfTotalDeaths
                    barColor =  BarColors.deceasedColor
                    barName = BarName.deceased.rawValue
               }
        ChartsLayer.setBarChart(labels: _barChartData.labels,
                                       values: values,
                                       inputView: uiView,
                                       barColor: barColor,
                                       barName: barName,
                                       barTag: self.selectionIndex)
               
    }
}


struct  BarChartControls: View {
    @Binding var selectionIndex: Int
    @State var isConfirmedSelected = true
    @State var isActiveSelected = false
    @State var isRecoveredSelected = false
    @State var isDeceasedSelected = false

    
    var body: some View {
        HStack{
            Button(action: {
                self.selectionIndex = 0
                self.isConfirmedSelected = true
                self.isActiveSelected = false
                self.isRecoveredSelected = false
                self.isDeceasedSelected = false
            }, label: {
                HStack (spacing: 1) {
                    Image(self.isConfirmedSelected ? "radiobuttonfilled" : "radiobuttonempty")
                    Text("Confirmed")
                    .foregroundColor(Color(Theme.labelColor))
                    .font(.system(size: 11))
                }
            })
                .foregroundColor(Color.white)
                //.padding()
                .background(Color.clear)
                .cornerRadius(5)
                .buttonStyle(PlainButtonStyle())
            
            
            
            Button(action: {
                self.selectionIndex = 1
                self.isConfirmedSelected = false
                self.isActiveSelected = true
                self.isRecoveredSelected = false
                self.isDeceasedSelected = false


            }, label: {
               HStack (spacing: 1){
                    Image(self.isActiveSelected ? "radiobuttonfilled" : "radiobuttonempty")
                    Text("Active")
                .foregroundColor(Color(Theme.labelColor))
                .font(.system(size: 11))

                }
            })
                .foregroundColor(Color.white)
                //.padding()
                .background(Color.clear)
                .cornerRadius(5)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.selectionIndex = 2
                self.isConfirmedSelected = false
                self.isActiveSelected = false
                self.isRecoveredSelected = true
                self.isDeceasedSelected = false


            }, label: {
                HStack (spacing: 1){
                    Image(self.isRecoveredSelected ? "radiobuttonfilled" : "radiobuttonempty")
                    Text("Recovered")
                    .foregroundColor(Color(Theme.labelColor))
                    .font(.system(size: 11))

                }
            })
                .foregroundColor(Color.white)
                //.padding()
                .background(Color.clear)
                .cornerRadius(5)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.selectionIndex = 3
                self.isConfirmedSelected = false
                self.isActiveSelected = false
                self.isRecoveredSelected = false
                self.isDeceasedSelected = true

            }, label: {
                HStack (spacing: 1){
                    Image(self.isDeceasedSelected ? "radiobuttonfilled" : "radiobuttonempty")
                    Text("Deceased")
                    .foregroundColor(Color(Theme.labelColor))
                    .font(.system(size: 11))

                }
            }).foregroundColor(Color.white)
                //.padding()
                .background(Color.clear)
                .cornerRadius(5)
            .buttonStyle(PlainButtonStyle())
            
        }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
            .background(Color.clear)
    }
}
