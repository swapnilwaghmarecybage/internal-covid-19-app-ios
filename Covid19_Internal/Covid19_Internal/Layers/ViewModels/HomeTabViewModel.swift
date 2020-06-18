//
//  HomeTabViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class HomeTabViewModel {
    
    private var arrayCountries = [CountryModel]()
    private var worldCount = CountryModel()
    private var indiaCount = CountryModel()
    
    
    init() {
        
    }
    /*
    func getWorldData(completion: @escaping (Bool)->()) {
    WorldCountWebService.callWorldCountWebService { (success, arrayWorldCountModel) in
           
        if let worldObject = arrayWorldCountModel?.first {
            print("World count model object details : total count: \(worldObject.totaCases)")
            print("World count model object details : total deaths: \(worldObject.totalDeaths)")
            print("World count model object details : total active: \(worldObject.activeCases)")
            print("World count model object details : total recovered: \(worldObject.totalRecovered)")

        
        
        }
        let sumOfTotalCases =  arrayWorldCountModel?.compactMap({Int($0.totaCases ?? "0")})//.reduce(0, +)
           print(sumOfTotalCases)
        // let sumOfTotalDeaths =  arrayWorldCountModel?.compactMap({Int($0.totalDeaths ?? "0")}).reduce(0, +)
           // let sumOfTotalActives =  arrayWorldCountModel?.compactMap({Int($0.activeCases ?? "0")}).reduce(0, +)
           // print("world API : \(String(describing: sumOfTotalCases))")
           // print("world API : \(String(describing: sumOfTotalDeaths))")
           // print("world API : \(String(describing: sumOfTotalActives))")

        
        completion(success)
        }
    }
    */
     func getCountriesData(completion: @escaping (Bool)->() ){
        AllCountriesCountWebService.callCountriesWebService { (success, arrayCountriesCountModel)  in
          
            self.worldCount.totalCases =  arrayCountriesCountModel?.compactMap({$0.totalCases}).reduce(0, +)
            self.worldCount.totalDeaths =  arrayCountriesCountModel?.compactMap({$0.totalDeaths}).reduce(0, +)
            self.worldCount.totalActive =  arrayCountriesCountModel?.compactMap({$0.totalActive}).reduce(0, +)
            self.worldCount.totalRecovered =  arrayCountriesCountModel?.compactMap({$0.totalRecovered}).reduce(0, +)
            self.worldCount.totalCritical =  arrayCountriesCountModel?.compactMap({$0.totalCritical}).reduce(0, +)
            self.worldCount.countryName = "World"
            self.worldCount.totalTests = arrayCountriesCountModel?.compactMap({$0.totalTests}).reduce(0, +)
            self.worldCount.newCases = arrayCountriesCountModel?.compactMap({$0.newCases}).reduce(0, +)
            self.worldCount.newDeaths = arrayCountriesCountModel?.compactMap({$0.newDeaths}).reduce(0, +)
            self.worldCount.newRecovered = arrayCountriesCountModel?.compactMap({$0.newRecovered}).reduce(0, +)
            
            print("World Count: \(self.worldCount)")
            
            

            completion(success)
        }
    }
        
     func getIndiaHistoricalData(completion: @escaping (Bool)->()) {
        AllIndiaHistoricalDataWebServices.callAllIndiaHitoricalDataWebService { (success, arrayHistoricalDataModels) in
            completion(success)
        }
    }
    
     func getAllDIctrictsData(completion: @escaping (Bool)->()){
        AllIndiaDistrictCountWebService.callDistrictWebService { (success, arrayDistrictModels) in
            completion(success)
        }
    }
    
}
