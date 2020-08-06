//
//  CountryModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/16/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct CountryResponse: Codable {
    let countryModels: [CountryModel]
}

struct CountryModel: Codable {
    var updated: Int?
    var country: String?
    var cases: Int?
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?
    var recovered: Int?
    var todayRecovered: Int?
    var active: Int?
    var critical: Int?
    var casesPerOneMillion: Double?
    var deathsPerOneMillion: Double?
    var tests: Int?
    var testsPerOneMillion: Double?
    var population: Int?
    var continent: String?
    var oneCasePerPeople: Double?
    var oneDeathPerPeople: Double?
    var oneTestPerPeople: Double?
    var activePerOneMillion: Double?
    var recoveredPerOneMillion: Double?
    var criticalPerOneMillion: Double?
    var countryInfo:CountryInfo?
    
   // init() {}
    
    
    struct CountryInfo: Codable {
        
        var _id: Int?
        var iso2: String?
        var iso3: String?
        var lat: Double?
        var long: Double?
        var flag: String?
        
    }
}


