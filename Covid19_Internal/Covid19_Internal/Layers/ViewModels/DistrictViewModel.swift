//
//  DistrictViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class DistrictViewModel {
    
    init() {}
    
    func getAllDIctrictsData(completion: @escaping (Bool)->()) {
        AllIndiaDistrictCountWebService.callDistrictWebService { (success, arrayDistrictModels) in
            completion(success)
        }
    }
    
    func getDistrictCount() -> Int {
        return 0
    }
    func getDistrictAtIndex(index:IndexPath) -> Any? {
        return nil
    }
}


