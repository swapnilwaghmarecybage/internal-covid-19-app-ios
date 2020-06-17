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
    
     func getCountriesData(completion: @escaping (Bool)->() ){
        AllCountriesCountWebService.callCountriesWebService { (success, arrayCountriesCountModel)  in
            //arrayCountriesCountModel.map({$0.}).reduce(0, +)
//            arrayCountriesCountModel?.map({ Int($0.totalCases)}).reduce(0, +)
            let sumOfTotalCases =  arrayCountriesCountModel?.compactMap({$0.totalCases}).reduce(0, +)
            let sumOfTotalDeaths =  arrayCountriesCountModel?.compactMap({$0.totalDeaths}).reduce(0, +)
            let sumOfTotalActives =  arrayCountriesCountModel?.compactMap({$0.totalActive}).reduce(0, +)
            let sumOfTotalRecovered =  arrayCountriesCountModel?.compactMap({$0.totalRecovered}).reduce(0, +)

            print("Country API Total Cases: \(String(describing: sumOfTotalCases))")
            print("Country API Total Deaths: \(String(describing: sumOfTotalDeaths))")
            print("Country API Total Active: \(String(describing: sumOfTotalActives))")
            print("Country API Total Recovered: \(String(describing: sumOfTotalRecovered))")

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
