//
//  TotalCountView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct TotalCountTableViewCell: View {
    
    var totalCountObject: CountryViewModel?
    init(_totalCountObject: CountryViewModel?){
        UITableViewCell.appearance().backgroundColor = .clear
        self.totalCountObject = _totalCountObject

    }
    
    private var widthOfcontainer: CGFloat = UIScreen.main.bounds.width
    private var heightOfContainer: CGFloat = 140
    private var scaleFactor: CGFloat = 0.35
    
    var body: some View {
        Group{
            HStack {
                VStack{
                    Text("Confirmed ").foregroundColor(Color(Theme.labelColor))
                    .frame(width: scaleFactor*widthOfcontainer, alignment: .center)
                    Divider()
                    Text("Recovered ").foregroundColor(Color(Theme.labelColor))
                    .frame(width: scaleFactor*widthOfcontainer, alignment: .center)
                    Divider()
                    Text("Deceased ").foregroundColor(Color(Theme.labelColor))
                    .frame(width: scaleFactor*widthOfcontainer, alignment: .center)
                }.frame( height: heightOfContainer)
               
                VStack{
                    Text("\(totalCountObject?.totalCases ?? 0) (+\(totalCountObject?.newCases ?? 0))").foregroundColor(Color(BarColors.confirmedColor))
                   .frame(width: (1-scaleFactor)*widthOfcontainer, alignment: .leading)
                    Divider()
                    Text("\(totalCountObject?.totalRecovered ?? 0) (+\(totalCountObject?.newRecovered ?? 0))").foregroundColor(Color(BarColors.recoveredColor))
                    .frame(width: (1-scaleFactor)*widthOfcontainer, alignment: .leading)
                    Divider()
                    Text("\(totalCountObject?.totalDeaths ?? 0) (+\(totalCountObject?.newDeaths ?? 0))").foregroundColor(Color(BarColors.deceasedColor))
                    .frame(width: (1-scaleFactor)*widthOfcontainer, alignment: .leading)
                }.frame( height: heightOfContainer, alignment: .leading)

            }
                .position(x: UIScreen.main.bounds.width/2, y: heightOfContainer/2)
                .background(Color(Theme.highlightedColor))
                .cornerRadius(10)
                .padding(.top, CGFloat(5))
                .padding(.bottom, CGFloat(5))
        }.padding(.leading, CGFloat(10))
        .padding(.trailing, CGFloat(10))
        
    }
}
