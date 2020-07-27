//
//  DistrictViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class DistrictViewModel {
    private var alldistricts: [DistrictModel]?
    private var stateData: IndiaHistoryModel.DayWiseData.Region?
    private var stateHistoryData: BarGraphDataType = ([],[],[],[],[])
    private var stateCountData: PieChartDataType = ([],[],false)
    
    init(_statedata:IndiaHistoryModel.DayWiseData.Region?,
         _stateHistoryData:[IndiaHistoryModel.DayWiseData.Region]?,
            completion: @escaping (Bool)->()) {
        self.stateData = _statedata
        self.stateCountData = self.getDataForStatePieChart(stateData: _statedata)
        self.stateHistoryData = self.getDataForStateBarChart(_stateHistoryData: _stateHistoryData)
        completion(true)
    }
    

    func getAllDistrictsData(completion: @escaping (Bool)->()) {
            AllIndiaDistrictCountWebService.callDistrictWebService { [weak self](success, arrayDistrictModels) in
                guard let self = self, success == true else {
                    completion(false)
                    return
                }
                self.alldistricts = arrayDistrictModels
                
                completion(true)
            }
    }
    
     func getDistrictCount() -> Int {
        
        if  let stateName = self.stateData?.loc, let _allDistricts = self.alldistricts {
            if let state = _allDistricts.filter({$0.stateName == stateName}).first,  let districtArrayForGivenState = state.districtData{
                return districtArrayForGivenState.count
            }
        }
        return 0
    }
    
    func getDistrictAtIndex(index:IndexPath) -> Any? {
        if let _allDistricts = self.alldistricts , let stateName = self.stateData?.loc{
            if let state = _allDistricts.filter({$0.stateName == stateName}).first,
                var districtArrayForGivenState = state.districtData,
            index.section > 1,
            districtArrayForGivenState.count > index.row {
                districtArrayForGivenState.sort(by: {$0.confirmed ?? 0 > $1.confirmed ?? 0})
                return districtArrayForGivenState[index.row]
            }
        }
        return nil
    }
    
     private func getDataForStatePieChart(stateData: IndiaHistoryModel.DayWiseData.Region?) -> PieChartDataType {
        guard let object = stateData else {
           return ([],[], false)
        }
        let deaths = object.deaths ?? 0
        let recovered = object.discharged ?? 0
        let active = object.totalActive ?? 0
        let labels = [BarName.active.rawValue,BarName.receovered.rawValue,BarName.deceased.rawValue]
        let values = [Double(active),Double(recovered),Double(deaths)]
            return (labels, values, false)
    }
    
    private func getDataForStateBarChart(_stateHistoryData:[IndiaHistoryModel.DayWiseData.Region]?) -> BarGraphDataType {
        
        guard let all_regions = _stateHistoryData else {
            return ([],[],[],[],[])
        }
            
         let allDates = all_regions.compactMap({$0.day ?? "" })
         let allConfirmed = all_regions.compactMap({Double($0.totalConfirmed ?? 0)})
         let allActive = all_regions.compactMap({Double($0.totalActive ?? 0)})
         let allDeaths = all_regions.compactMap({Double($0.deaths ?? 0)})
         let allRecovered = all_regions.compactMap({Double($0.discharged ?? 0)})
         
        return (allDates, allConfirmed, allActive, allRecovered, allDeaths)
                     
    }
    
    func getPieChartDataForState() -> PieChartDataType {
        return self.stateCountData
    }
    
    func getBarChartDataForState() -> BarGraphDataType {
        return self.stateHistoryData
    }
    
    func numberOfRowsAtIndexPath(section: Int) -> Int {
        switch section {
        case 0:
            if self.stateCountData.labes.count > 0{
                return 1
            }
            return 0
        case 1:
            if self.stateHistoryData.labels.count > 0{
                return 1
            }
            return 0
        case 2:
            if  let stateName = self.stateData?.loc, let _allDistricts = self.alldistricts {
                if let state = _allDistricts.filter({$0.stateName == stateName}).first,  let districtArrayForGivenState = state.districtData{
                    return districtArrayForGivenState.count
                }
            }
            return 0
            
        default:
            return 0
        }
    }
}


