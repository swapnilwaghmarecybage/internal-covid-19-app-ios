//
//  AllCountriesWebServiceParser.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllCountriesParser {
    
    static func parse(arrayOfCountriesDataDictionaries:[Dictionary<String, Any>], completion: @escaping ([CountryModel]?)->())  {
       
        let arrayCountryModel:[CountryModel]? =
                arrayOfCountriesDataDictionaries.map { (object: [String: Any]) -> CountryModel in
                var modelObject = CountryModel()
                modelObject.lastUpdated = object["updated"] as? Int
                modelObject.countryName = object["country"] as? String
                modelObject.totalCases = object["cases"] as? Int
                modelObject.newCases = object["todayCases"] as? Int
                modelObject.totalDeaths = object["deaths"] as? Int
                modelObject.newDeaths = object["todayDeaths"] as? Int
                modelObject.totalRecovered = object["recovered"] as? Int
                modelObject.newRecovered = object["todayRecovered"] as? Int
                modelObject.totalActive = object["active"] as? Int
                modelObject.totalCritical = object["critical"] as? Int
                modelObject.totalCasesPerOneMillion = object["casesPerOneMillion"] as? Int
                modelObject.totalDeathsPerOneMillion = object["deathsPerOneMillion"] as? Int
                modelObject.totalTests = object["tests"] as? Int
                modelObject.totalTestsPerOneMillion = object["testsPerOneMillion"] as? Int
                modelObject.population = object["population"] as? Int
                modelObject.continent = object["continent"] as? Int
                modelObject.oneCasePerPeople = object["oneCasePerPeople"] as? Int
                modelObject.oneDeathPerPeople = object["oneDeathPerPeople"] as? Int
                modelObject.oneTestPerPeople = object["oneTestPerPeople"] as? Int
                modelObject.activePerOneMillion = object["activePerOneMillion"] as? Int
                modelObject.recoveredPerOneMillion = object["recoveredPerOneMillion"] as? Int
                modelObject.criticalPerOneMillion = object["criticalPerOneMillion"] as? Int
                if let countryInfoDictionary = object["countryInfo"] as? [String: Any] {
                modelObject.countryDetails = CountryModel.CountryDetails()
                modelObject.countryDetails?.id = countryInfoDictionary["_id"] as? Int
                modelObject.countryDetails?.iso2 = countryInfoDictionary["iso2"] as? String
                modelObject.countryDetails?.iso3 = countryInfoDictionary["iso3"] as? String
                modelObject.countryDetails?.latitude = countryInfoDictionary["lat"] as? Int
                modelObject.countryDetails?.longitude = countryInfoDictionary["long"] as? Int
                modelObject.countryDetails?.flag = countryInfoDictionary["flag"] as? String

                    }
                return modelObject
            }
        completion(arrayCountryModel)
    }
}
