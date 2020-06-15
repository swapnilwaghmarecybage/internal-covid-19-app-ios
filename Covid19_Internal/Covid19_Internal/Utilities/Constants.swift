//
//  Constants.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

enum HttpMethod {
    
    case get // type is Get
    case post // Type is Post
    case delete // type is Delete
}



  struct API {
    static let district = "https://api.covid19india.org/state_district_wise.json"
    static let all_india_historical_data = "ttps://api.rootnet.in/covid19-in/stats/history"
    static let all_countries = " https://disease.sh/v2/countries?yesterday=true&sort=cases&allowNull=false"
    static let world_count = "https://covid-19.dataflowkit.com/v1"
    }
    
    

