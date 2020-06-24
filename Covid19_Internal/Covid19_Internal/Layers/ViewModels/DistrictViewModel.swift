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
    init() {}
    
    func getAllDIctrictsData(completion: @escaping (Bool)->()) {
        AllIndiaDistrictCountWebService.callDistrictWebService { [weak self](success, arrayDistrictModels) in
            guard let self = self, success == true else {
                completion(false)
                return
            }
            self.alldistricts = arrayDistrictModels
            completion(true)
        }
    }
    
    func getDistrictCount(forState stateName:String) -> Int {
        if let _allDistricts = self.alldistricts {
            if let state = _allDistricts.filter({$0.stateName == stateName}).first,  let districtArrayForGivenState = state.districtData{
                return districtArrayForGivenState.count
            }
        }
        return 0
    }
    
    func getDistrictAtIndex(index:IndexPath, forStateName stateName: String) -> Any? {
        if let _allDistricts = self.alldistricts {
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
}


