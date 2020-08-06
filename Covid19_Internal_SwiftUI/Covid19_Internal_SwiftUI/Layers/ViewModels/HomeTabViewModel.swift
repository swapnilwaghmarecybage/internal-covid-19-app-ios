//
//  HomeTabViewModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import SwiftUI

class HomeTabViewModel: ObservableObject {
    
    @Published private var arrayCountries: [CountryViewModel] = [CountryViewModel]()
    @Published private var worldCount: CountryViewModel?
    @Published private var indiaCount: CountryViewModel?
    @Published private var indiaHistoryModel: IndiaHistoryModel?
    @Published private var statesOfIndia: [StateViewModel] = [StateViewModel]()
    @Published var selectedSegmentIndex = 0
    private var districtModel:[String: DistrictModel]?

    init() {
        getCountriesData()
        getIndiaHistoricalData()
        getAllDistrictsData()
    }
  

    func getCountriesData(){
            AllCountriesCountWebService.callCountriesWebService { [weak self](success, arrayCountriesCountModel) in
               
                guard let self = self, success == true ,let _arrayCountriesCountModel = arrayCountriesCountModel else {
                    return
                }
                 self.arrayCountries =  _arrayCountriesCountModel.map(CountryViewModel.init)

                var _worldCount = CountryModel()
                _worldCount.cases =  _arrayCountriesCountModel.compactMap({$0.cases}).reduce(0, +)
                _worldCount.deaths =  _arrayCountriesCountModel.compactMap({$0.deaths}).reduce(0, +)
                _worldCount.active =  _arrayCountriesCountModel.compactMap({$0.active}).reduce(0, +)
                _worldCount.recovered =  _arrayCountriesCountModel.compactMap({$0.recovered}).reduce(0, +)
                _worldCount.critical =  _arrayCountriesCountModel.compactMap({$0.critical}).reduce(0, +)
                _worldCount.country = "World"
                _worldCount.tests = _arrayCountriesCountModel.compactMap({$0.tests}).reduce(0, +)
                _worldCount.todayCases = _arrayCountriesCountModel.compactMap({$0.todayCases}).reduce(0, +)
                _worldCount.todayDeaths = _arrayCountriesCountModel.compactMap({$0.todayDeaths}).reduce(0, +)
                _worldCount.todayRecovered = _arrayCountriesCountModel.compactMap({$0.todayRecovered}).reduce(0, +)
                self.worldCount = CountryViewModel(country: _worldCount)
                self.indiaCount = self.arrayCountries.filter({$0.countryName == "India"}).first

            }        
    }
        
     func getIndiaHistoricalData() {
        AllIndiaHistoricalDataWebServices.callAllIndiaHitoricalDataWebService {[weak self] (success, _indiaHistoryModel) in
            guard let self = self , success == true else {
                return
            }
            if let modelObject = _indiaHistoryModel{
                self.indiaHistoryModel = modelObject
                if let data = modelObject.data {
                     

                    if let date = modelObject.lastRefreshed?.components(separatedBy: "T").first,let _regions = data.filter({$0.day == date}).first?.regional {
                        self.statesOfIndia = _regions.map(StateViewModel.init)
                    } else if let date = modelObject.lastOriginUpdate?.components(separatedBy: "T").first,let _regions = data.filter({$0.day == date}).first?.regional {
                        self.statesOfIndia = _regions.map(StateViewModel.init)
                    } else {
                        if let _regions = data.last?.regional {
                            self.statesOfIndia = _regions.map(StateViewModel.init)
                        }
                    }
                    self.statesOfIndia = self.statesOfIndia.sorted(by: {$0.totalConfirmed  > $1.totalConfirmed })
                }
            }
        }
    }
    
    
    func getAllDistrictsData() {
        AllIndiaDistrictCountWebService.callDistrictWebService { [weak self](success, _districtModel) in
            guard let self = self, success == true else {
                return
            }
            self.districtModel = _districtModel
        }
    }
    
    func getWorldObjcect() -> CountryViewModel? {
        return worldCount ?? nil
    }
    
    func getDataForWorldPieChart() -> PieChartDataType {
        if let object = self.worldCount {
            let labels = [BarName.active.rawValue,BarName.receovered.rawValue,BarName.deceased.rawValue]
            let values = [Double(object.totalActive),Double(object.totalRecovered),Double(object.totalDeaths)]
            return (labels, values, true)
        }
        return ([],[], false)
    }
    
    func getCountries() -> [CountryViewModel] {
        return self.arrayCountries
    }
    
    func getCountriesCount() -> Int{
           return self.arrayCountries.count
       }
    
    func getIndiaObject() -> CountryViewModel? {
        return indiaCount ?? nil
    }
  
    func getStatesOfIndia() -> [StateViewModel] {
        return self.statesOfIndia
    }
    
    func getStatesCount() -> Int{
        return self.statesOfIndia.count
    }
    
    
    func getDataForIndiaBarChart() -> BarGraphDataType{
            
        let allDates = self.indiaHistoryModel?.data?.compactMap({$0.day ?? ""  }) ?? []
       let allConfirmed = self.indiaHistoryModel?.data?.compactMap({Double($0.summary?.total ?? 0)}) ?? []
       let allActive = self.indiaHistoryModel?.data?.compactMap({Double($0.summary?.active() ?? 0)}) ?? []
        let allDeaths = self.indiaHistoryModel?.data?.compactMap({Double($0.summary?.deaths ?? 0)}) ?? []
        let allRecovered = self.indiaHistoryModel?.data?.compactMap({Double($0.summary?.discharged ?? 0)}) ?? []
        return (allDates, allConfirmed, allActive, allRecovered ,allDeaths)
 
    }
    
    
    func getDataForStateHistoryBarChart(_state: StateViewModel) -> BarGraphDataType{
       
        let  all_regions = self.indiaHistoryModel?.data?.compactMap({$0.regional?.compactMap({ (region:IndiaHistoryModel.DayWiseData.Region) -> IndiaHistoryModel.DayWiseData.Region? in
            
            if let location = region.loc, location.elementsEqual(_state.loc){
                return region
            }
            return nil
            })}).flatMap({$0})
        
        let all_days = self.indiaHistoryModel?.data?.compactMap({ (object) -> String? in
           
            if let regions = object.regional, regions.contains(where: {$0.loc == _state.loc}) == true {
                return object.day
            }
            return nil
        })
           let allConfirmed = all_regions?.compactMap({Double($0.totalConfirmed ?? 0)})
           let allActive = all_regions?.compactMap({Double($0.active() ?? 0)})
           let allDeaths = all_regions?.compactMap({Double($0.deaths ?? 0)})
           let allRecovered = all_regions?.compactMap({Double($0.discharged ?? 0)})

        return  (all_days ?? [], allConfirmed ?? [], allActive ?? [], allRecovered ?? [], allDeaths ?? [])
        
    }
    
    
    func getPieChartDataForState(_stateData: StateViewModel) -> PieChartDataType {
        let deaths = _stateData.deaths
        let recovered = _stateData.discharged
        let active = _stateData.active
        let labels = [BarName.active.rawValue,BarName.receovered.rawValue,BarName.deceased.rawValue]
        let values = [Double(active),Double(recovered),Double(deaths)]
        return (labels, values, false)
    }
   
    func getAllDistrictsOfState(state:StateViewModel) -> [DistrictViewModel] {
        if let test =  self.districtModel?.filter({$0.key == state.loc}).values.first?.districtData{
            let cells = test.map { (key, value) -> DistrictViewModel in
                return DistrictViewModel(_name: key, _cases: value)
            }
            return cells.sorted(by: {$0.confirmed  > $1.confirmed })
        }
        return [DistrictViewModel]().sorted(by: {$0.confirmed  > $1.confirmed })
    }
    
}
