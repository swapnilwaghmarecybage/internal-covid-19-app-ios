//
//  CountryViewModel.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class CountryViewModel: Identifiable {
    
    let id = UUID()
    
    let country: CountryModel
    
    init(country: CountryModel) {
        self.country = country
    }
    
    var totalCases: Int {
        return self.country.cases ?? 0
    }
    
    var totalRecovered: Int {
        return self.country.recovered ?? 0
    }
    
    var totalDeaths: Int {
        return self.country.deaths ?? 0
    }
    
    var countryName: String {
        return self.country.country ?? ""
    }
    
    var totalActive: Int {
        return self.country.active ?? 0
    }
    
    var newCases: Int {
        return self.country.todayCases ?? 0
    }
    
    var newRecovered: Int {
        return self.country.todayRecovered ?? 0
    }
    
    var newDeaths: Int {
        return self.country.todayDeaths ?? 0
    }
    
    var flagURL: String {
        return self.country.countryInfo?.flag ?? ""
    }
}

