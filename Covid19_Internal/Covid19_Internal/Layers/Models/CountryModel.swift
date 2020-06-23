//
//  CountryModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/16/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct CountryModel {
    var lastUpdated: Int?
    var countryName: String?
    var totalCases: Int?
    var newCases: Int?
    var totalDeaths: Int?
    var newDeaths: Int?
    var totalRecovered: Int?
    var newRecovered: Int?
    var totalActive: Int?
    var totalCritical: Int?
    var totalCasesPerOneMillion: Int?
    var totalDeathsPerOneMillion: Int?
    var totalTests: Int?
    var totalTestsPerOneMillion: Int?
    var population: Int?
    var continent: Int?
    var oneCasePerPeople: Int?
    var oneDeathPerPeople: Int?
    var oneTestPerPeople: Int?
    var activePerOneMillion: Int?
    var recoveredPerOneMillion: Int?
    var criticalPerOneMillion: Int?
    var countryDetails:CountryDetails?
    init() {}
    
    
    struct CountryDetails {
        
        var id: Int?
        var iso2: String?
        var iso3: String?
        var latitude: Int?
        var longitude: Int?
        var flag: String?
        
    }
}


