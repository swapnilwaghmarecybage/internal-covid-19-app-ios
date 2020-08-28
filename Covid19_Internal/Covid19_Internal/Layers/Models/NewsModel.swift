//
//  NewsModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/13/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct NewsModel: Codable {
    var content: String?
    var date: Double?
    var link: String?
    var title: String?
    var photo: String?
    var subject: String?
    var id: String?
   private let photoBaseUrl = "https://firebasestorage.googleapis.com/v0/b/covidcare-3474d.appspot.com/o/covidcare%2F"
   private let photoEndUrl = "?alt=media"
    
    func getPhotoUrl() -> String? {
        if let _photeName = photo{
          return  "\(photoBaseUrl)\(_photeName)\(photoEndUrl)"
        }
        return nil
    }
}
