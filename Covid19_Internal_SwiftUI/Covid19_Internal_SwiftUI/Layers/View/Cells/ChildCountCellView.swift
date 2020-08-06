//
//  ChildCountCellView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct ChildCountTableViewCell: View {
   

    init(_regionDetails: Any?) {
        if(_regionDetails is CountryViewModel){
            let countryObject = _regionDetails as! CountryViewModel
            isFlagAvaibalbe = true
            flagURL = countryObject.flagURL
            confirmed = countryObject.totalCases
            recovered = countryObject.totalRecovered
            deceased = countryObject.totalDeaths
            regionName = countryObject.countryName
            
        } else if (_regionDetails is StateViewModel){
            let stateObject = _regionDetails as! StateViewModel

            isFlagAvaibalbe = false
                confirmed = stateObject.totalConfirmed
                recovered = stateObject.discharged
                deceased = stateObject.deaths
            regionName = stateObject.loc
            
        } else if (_regionDetails is DistrictViewModel){
            let districtObject = _regionDetails as! DistrictViewModel

            isFlagAvaibalbe = false
                confirmed = districtObject.confirmed
                recovered = districtObject.recovered
                deceased = districtObject.deceased
            regionName = districtObject.districtName

        }
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    private var isFlagAvaibalbe = false
    private var flagURL = ""
    private var confirmed = 0
    private var recovered = 0
    private var deceased = 0
    private var regionName = ""
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    private var heightOfContainer: CGFloat = 120
    private var heightScaleFactorForTitle: CGFloat = 0.40
    
    var body: some View {
        
        Group{
            VStack{
                HStack{
                        // show Image
                    if(isFlagAvaibalbe){
                        NationalFlag(imageUrl: flagURL)
                        .frame(width: 0.15 * (screenWidth - 50),
                               height: (heightScaleFactorForTitle * heightOfContainer),
                               alignment: .center)
                        .padding(.top, CGFloat(15))
                        .cornerRadius(5)

                    }
                        
                    Text("\(regionName)")
                        .foregroundColor(Color(Theme.labelColor))
                        .font(.system(size: 19))
                        .frame(width: (1 - (isFlagAvaibalbe ? 0.15 : 0)) * (screenWidth - 50),
                               height: (heightScaleFactorForTitle * heightOfContainer),
                               alignment: .leading)
                        .padding(.top, CGFloat(15))

                }.frame(width: 0.85 * (screenWidth - 50),
                        height: (heightScaleFactorForTitle * heightOfContainer))
                    .padding(.leading,CGFloat(25))

                
                HStack{
                    
                    VStack{
                        Text("Confirmed").foregroundColor(Color(Theme.labelColor))
                            .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                                   alignment:  .center)
                            .font(.system(size: 17))
                        
                        Text("\(confirmed)").foregroundColor(Color(BarColors.confirmedColor))
                        .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                               alignment:  .center)
                        .font(.system(size: 17))

                    }.frame(minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity,
                            alignment: .center)
                    VStack{
                        Text("Recovered").foregroundColor(Color(Theme.labelColor))
                        .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                               alignment:  .center)
                        .font(.system(size: 17))

                        Text("\(recovered)").foregroundColor(Color(BarColors.recoveredColor))
                        .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                               alignment:  .center)
                        .font(.system(size: 17))

                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,
                            alignment: .center)

                    VStack{
                        Text("Deceased").foregroundColor(Color(Theme.labelColor))
                        .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                               alignment:  .center)
                        .font(.system(size: 17))

                        Text("\(deceased)").foregroundColor(Color(BarColors.deceasedColor))
                        .frame(height: ((1 - heightScaleFactorForTitle) * heightOfContainer) * 0.50,
                               alignment:  .center)
                        .font(.system(size: 17))

                    }.frame(minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity,
                            alignment: .center)

                    
                }.frame(width: screenWidth - 50,
                        height: ((1 - heightScaleFactorForTitle) * heightOfContainer))
                    .padding(.bottom, CGFloat(5))


                
            }.frame(alignment:.center)
                .position(x: (UIScreen.main.bounds.width/2)-25, y: heightOfContainer/2)
                .background(Color(Theme.highlightedColor))
                .cornerRadius(10)
                .padding(.top, CGFloat(5))
                .padding(.bottom, CGFloat(5))
            
        }.padding(.leading, CGFloat(10))
        .padding(.trailing, CGFloat(10))
        
    }
}
