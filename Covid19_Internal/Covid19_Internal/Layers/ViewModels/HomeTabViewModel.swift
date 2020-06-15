//
//  HomeTabViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct HomeTabViewModel {
    
    init() {}
    
   private func getWorldData(completion: @escaping (Bool)->()) {
    WorldCountWebService.callWorldCountWebService { (success, worldCountModel) in
            completion(success)
        }
    }
    
    private func getCountriesData(completion: @escaping (Bool)->() ){
        AllCountriesCountWebService.callCountriesWebService { (success, arrayCountriesCountModel)  in
            completion(success)
        }
    }
        
    private func getIndiaHistoricalData(completion: @escaping (Bool)->()) {
        AllIndiaHistoricalDataWebServices.callAllIndiaHitoricalDataWebService { (success, arrayHistoricalDataModels) in
            completion(success)
        }
    }
    
    private func getAllDIctrictsData(completion: @escaping (Bool)->()){
        AllIndiaDistrictCountWebService.callDistrictWebService { (success, arrayDistrictModels) in
            completion(success)
        }
    }
    
}
