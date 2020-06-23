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

enum SegmentSelectionIndex:Int {
    case India //0
    case World //1
}


  struct API {
    static let district = "https://api.covid19india.org/state_district_wise.json"
    static let all_india_historical_data = "https://api.rootnet.in/covid19-in/stats/history"
    static let all_countries = "https://disease.sh/v2/countries?yesterday=true&sort=cases&allowNull=false"
    static let world_count = "https://covid-19.dataflowkit.com/v1"
    }
    
    
class Utilities {

    static let sharedInstance = Utilities()
    private init(){}
    
    func getDateInStringFormat(requiredDateFormat:String ) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = requiredDateFormat
        return formatter.string(from: yourDate!)
        
    }
}
