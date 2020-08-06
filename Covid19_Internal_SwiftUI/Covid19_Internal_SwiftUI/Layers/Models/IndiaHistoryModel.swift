//
//  IndiaHistoryModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/23/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation


struct IndiaHistoryModel: Codable {
    var success: Bool
    var data: [DayWiseData]?
    var lastRefreshed: String?
    var lastOriginUpdate: String?
    
    struct DayWiseData: Codable {
        var day: String?
        var summary: SummaryAllIndia?
        var regional:[Region]?
        
        
        struct SummaryAllIndia:Codable {
            
            var total: Int?
            var confirmedCasesIndian: Int?
            var confirmedCasesForeign: Int?
            var discharged: Int?
            var deaths: Int?
            var confirmedButLocationUnidentified: Int?
            func active () -> Int? {
                if let _total = total, let _discharged = discharged, let _deaths = deaths{
                    return _total - (_discharged + _deaths)
                }
                return nil
            }
        }
        
        struct Region: Codable {
            var loc: String?
            var confirmedCasesIndian: Int?
            var confirmedCasesForeign: Int?
            var discharged: Int?
            var deaths: Int?
            var totalConfirmed: Int?
            func active () -> Int? {
                if let _total = totalConfirmed, let _discharged = discharged, let _deaths = deaths{
                    return _total - (_discharged + _deaths)
                }
                return nil
            }
        }
    }
    
}

