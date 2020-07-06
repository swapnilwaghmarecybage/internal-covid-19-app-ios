//
//  IndiaHistoryModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation


struct IndiaHistoryModel {
    var success: Bool = false
    var data: [DayWiseData]?
    var lastRefreshed: String?
    var lastOriginUpdate: String?
    
    struct DayWiseData {
        var day: String?
           var summaryAllIndia: SummaryAllIndia?
           var allRegions:[Region]?
           
           
           struct SummaryAllIndia {
               var total: Int?
               var confirmedCasesIndian: Int?
               var confirmedCasesForeign: Int?
               var discharged: Int?
               var deaths: Int?
               var confirmedButLocationUnidentified: Int?
            var totalActive:Int?
           }

           struct Region {
               var loc: String?
               var confirmedCasesIndian: Int?
               var confirmedCasesForeign: Int?
               var discharged: Int?
               var deaths: Int?
               var totalConfirmed: Int?
               var totalActive: Int?
                var day: String?
           }
    }
   
}

