//
//  CovidList.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct HomeList: View {
    
    @ObservedObject var viewModel:HomeTabViewModel
    @Binding private var selectedSegmentedIndex: Int
    
    init(_viewModel: HomeTabViewModel,_index:Binding<Int>) {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
        viewModel = _viewModel
        self._selectedSegmentedIndex = _index
    }
    var body: some View {
        List {
            if(self.selectedSegmentedIndex == 0){
                TotalCountTableViewCell(_totalCountObject: viewModel.getIndiaObject())
                GraphCell(_chartDataTpe: viewModel.getDataForIndiaBarChart())
                ForEach(viewModel.getStatesOfIndia()) { currentState in

                    ZStack {
                    ChildCountTableViewCell(_regionDetails: currentState )
                    NavigationLink(destination: DistrictList(_stateViewModel: currentState,
                     _alldistricts: self.viewModel.getAllDistrictsOfState(state: currentState),
                     _barGraph: self.viewModel.getDataForStateHistoryBarChart(_state: currentState),
                    _pieChart: self.viewModel.getPieChartDataForState(_stateData: currentState))) {
                        EmptyView().frame(width: 0, height: 0) // To avoid Navigation link arrow
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                }
            } else {
                TotalCountTableViewCell(_totalCountObject: viewModel.getWorldObjcect())
                GraphCell(_chartDataTpe: viewModel.getDataForWorldPieChart())
                ForEach(viewModel.getCountries()) { currentCountry in
                    ChildCountTableViewCell(_regionDetails: currentCountry )
                }
            }
        }
        .listRowBackground(Color.clear)
    }
}
