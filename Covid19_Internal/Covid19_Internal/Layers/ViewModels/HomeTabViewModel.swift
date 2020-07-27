//
//  HomeTabViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class HomeTabViewModel {
    
    private var arrayCountries: [CountryModel]?
    private var worldCount: CountryModel?
    private var indiaCount: CountryModel?
    private var indiaHistoryModel: IndiaHistoryModel?
    private var todaysDataIndia: IndiaHistoryModel.DayWiseData?
   
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: NetworkReceivedNotification,
                                               object: nil)

    }
    
    @objc func reachabilityChanged(notification: Notification) {

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
            AllCountriesCountWebService.callCountriesWebService { [weak self](success, arrayCountriesCountModel) in
               
                guard let self = self, success == true else {
                    completion(false)
                    return
                }
                self.worldCount = CountryModel()
                self.worldCount?.totalCases =  arrayCountriesCountModel?.compactMap({$0.totalCases}).reduce(0, +)
                self.worldCount?.totalDeaths =  arrayCountriesCountModel?.compactMap({$0.totalDeaths}).reduce(0, +)
                self.worldCount?.totalActive =  arrayCountriesCountModel?.compactMap({$0.totalActive}).reduce(0, +)
                self.worldCount?.totalRecovered =  arrayCountriesCountModel?.compactMap({$0.totalRecovered}).reduce(0, +)
                self.worldCount?.totalCritical =  arrayCountriesCountModel?.compactMap({$0.totalCritical}).reduce(0, +)
                self.worldCount?.countryName = "World"
                self.worldCount?.totalTests = arrayCountriesCountModel?.compactMap({$0.totalTests}).reduce(0, +)
                self.worldCount?.newCases = arrayCountriesCountModel?.compactMap({$0.newCases}).reduce(0, +)
                self.worldCount?.newDeaths = arrayCountriesCountModel?.compactMap({$0.newDeaths}).reduce(0, +)
                self.worldCount?.newRecovered = arrayCountriesCountModel?.compactMap({$0.newRecovered}).reduce(0, +)
                
                if let receivedArray = arrayCountriesCountModel{
                    self.arrayCountries = receivedArray
                     let filteredArray = receivedArray.filter({$0.countryName == "India"})
                    if  !filteredArray.isEmpty   {
                        self.indiaCount = filteredArray[0]
                    }
                }
                completion(true)
            }

        
    }
        
     func getIndiaHistoricalData(completion: @escaping (Bool)->()) {
        AllIndiaHistoricalDataWebServices.callAllIndiaHitoricalDataWebService {[weak self] (success, _indiaHistoryModel) in
            guard let self = self , success == true else {
                completion(false)
                return
            }
            if let modelObject = _indiaHistoryModel{
                self.indiaHistoryModel = modelObject
                if let data = modelObject.data {
                    
                    if let date = modelObject.lastRefreshed?.components(separatedBy: "T").first,let _todaysData = data.filter({$0.day == date}).first {
                        self.todaysDataIndia = _todaysData
                    } else if let date = modelObject.lastOriginUpdate?.components(separatedBy: "T").first,let _todaysData = data.filter({$0.day == date}).first {
                        self.todaysDataIndia = _todaysData
                    } else {
                        self.todaysDataIndia = data.last
                    }
                }
            }
            completion(true)
        }
    }
    
    
    func getWorldObjcect() -> CountryModel? {
        return worldCount ?? nil
    }
    
    func getDataForWorldPieChart() -> PieChartDataType {
        if let object = self.worldCount, let deaths = object.totalDeaths, let recovered = object.totalRecovered, let active = object.totalActive{
            let labels = [BarName.active.rawValue,BarName.receovered.rawValue,BarName.deceased.rawValue]
            let values = [Double(active),Double(recovered),Double(deaths)]
            return (labels, values, true)
        }
        return ([],[], false)
    }
    

    
    func getIndiaObject() -> CountryModel? {
        return indiaCount ?? nil
    }
    
    func getCountryAtIndex(index: IndexPath) -> Any? {
        if let array = arrayCountries, array.count > index.row , index.section > 1 {
            return array[index.row]

        }
        
        return nil
    }
    
    func getCountriesCount() -> Int{
        return arrayCountries?.count ?? 0
    }
    
    func getStatesCount() -> Int{
        return self.todaysDataIndia?.allRegions?.count ?? 0
    }
    
    func getStateAtIndex(index:IndexPath) -> Any? {
        if let allRegions = self.todaysDataIndia?.allRegions , allRegions.count > index.row{
            return allRegions[index.row]
        }
        return  nil
    }
    
    func getDataForIndiaBarChart() -> BarGraphDataType{
            
        let allDates = self.indiaHistoryModel?.data?.compactMap({$0.day ?? ""  }) ?? []
       let allConfirmed = self.indiaHistoryModel?.data?.compactMap({Double($0.summaryAllIndia?.total ?? 0)}) ?? []
        let allActive = self.indiaHistoryModel?.data?.compactMap({Double($0.summaryAllIndia?.totalActive ?? 0)}) ?? []
        let allDeaths = self.indiaHistoryModel?.data?.compactMap({Double($0.summaryAllIndia?.deaths ?? 0)}) ?? []
        let allRecovered = self.indiaHistoryModel?.data?.compactMap({Double($0.summaryAllIndia?.discharged ?? 0)}) ?? []
        return (allDates, allConfirmed, allActive, allRecovered ,allDeaths)
           
    }
    
    
    func getDataForStateHistoryBarChart(_stateName: String?) -> [IndiaHistoryModel.DayWiseData.Region]?{
       
        guard let stateName = _stateName  else {
            return nil
        }
        
        let  all_regions = self.indiaHistoryModel?.data?.compactMap({$0.allRegions?.compactMap({ (region:IndiaHistoryModel.DayWiseData.Region) -> IndiaHistoryModel.DayWiseData.Region? in
            
            if let location = region.loc, location.elementsEqual(stateName){
                return region
            }
            return nil
            })}).flatMap({$0})
        
        return all_regions
    }
    
}
