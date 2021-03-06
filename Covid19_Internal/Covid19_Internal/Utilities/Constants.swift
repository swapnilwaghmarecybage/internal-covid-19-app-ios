//
//  Constants.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit

typealias BarGraphDataType = (labels: [String], valuesOfTotalConfirmed:[Double],
                        valueOfTotalActive:[Double], valueOfTotalRecovered:[Double],
                        valueOfTotalDeaths:[Double])

typealias Dos_And_Donts = (title:String,imageName:String,description: String)

typealias PieChartDataType = (labes: [String], values:[Double],shouldShowPercentage: Bool)

struct BarColors {
    static var confirmedColor: UIColor { return UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0) }
    static var activeColor: UIColor  { return UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 1.0) }
    static var recoveredColor: UIColor { return UIColor(red: 39/255, green: 174/255, blue: 69/255, alpha: 1.0) }
    static var deceasedColor: UIColor { return UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1.0) }
}

struct Theme {
    static var backgroundColor: UIColor {return UIColor(red: 60/255, green: 100/255, blue: 123/255, alpha: 1.0)}
    static var highlightedColor: UIColor {return UIColor(red: 25/255, green: 57/255, blue: 79/255, alpha: 1.0)}
    static var labelColor: UIColor {return UIColor.white}
    static var outlineColor: UIColor {return UIColor.white}
    static var unSelectedSegmentControlColor: UIColor {return UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1.0)}
    static var selectedSegmentControlColor: UIColor {return UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0) }
    static var tabUnselectedColor: UIColor{ return UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1.0) }
    static var tabselectedColor: UIColor{ return UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1.0) }
    static var navogationBarbackgroundColor: UIColor {return UIColor(red: 25/255, green: 57/255, blue: 79/255, alpha: 1.0)}
    static var tabBarBackgroundColor: UIColor {return UIColor(red: 25/255, green: 57/255, blue: 79/255, alpha: 1.0)}
}

struct Guide {
    static var Dos: [Dos_And_Donts] {return[("Hand Wash","Hand Wash","Regular hand wash for 20 seconds will help you avoid germs or any kind of infection."),
                                                                            ("Cover Your Mouth & Nose","Cover Your Mouth & Nose","Covering your mouth and nose while sneezing or when anyone next to coughs or sneezes can do you a lot better."),
                                                                            ("Consult A Doctor If Sick","Consult A Doctor If Sick","If you are suffering from a common cold, cough, nausea, vomiting, shortness of breath and fatigue make it a point to consult a doctor at the earliest."),
                                                                            ("Stay Indoors","Stay Indoors","Avoid being in crowded places. An infected person can spread the virus instantly and crowded places is a good way to accomplish this.")]}
    
    static var Donts: [Dos_And_Donts] {return[("Don’t Touch Your Face","Don’t Touch Your Face","Do not touch your face, nose and mouth often. This avoids the risks of developing the virus."),
                                                                              ("Avoid Close Contact","Avoid Close Contact","Do not get close to anyone, especially touching or laughing closely. Also, use anti-pollution masks when out with friends or family."),
                                                                              ("Do Not Spit","Do Not Spit","Spitting can increase the spread of the virus. Avoid spiting at in public and home. Also, avoid getting close to a sick person suffering from cold and cough."),
                                                                              ("Don’t Panic, Take It Easy","Don’t Panic, Take It Easy","Most often a state of fear can lead to taking wrong decisions and use of self-medication. All you need to keep in mind is hygiene.")]}
    static var psycologicalGuidelines = "• Isolate yourself from news about the virus. (Everything we need to know, we already know).\n\n • Don't look out for death toll. It's not a cricket match to know the latest score. Avoid that.\n\n• Don't look for additional information on the Internet, it would weaken your mental state.\n\n• Avoid sending fatalistic messages. Some people don't have the same mental strength as you (Instead of helping, you could activate pathologies such as depression).\n\n• If possible, listen to music at home at a pleasant volume. Look for board games to entertain children, tell stories and future plans.\n\n• Maintain discipline in the home by washing your hands, putting up a sign or alarm for everyone in the house.\n\n• Your positive mood will help protect your immune system, while negative thoughts have been shown to depress your immune system and make it weak against viruses.\n\n• Most importantly, firmly believe that this shall also pass and we will be safe.... !\n\n\n Stay mentally positive...Stay safe!"
    static var lessCommonSymptoms = "• Aches and pains\n• Sore throa\n• Diarrhoea\n• Conjunctivitis\n• Headache\n• Loss of taste or smell\n• A rash on skin\n• Discolouration of fingers or toes"
}

let NetworkReceivedNotification = NSNotification.Name("Network received")

let App_Name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""

enum BarName: String {
    case confirmed = "Confirmed"
    case active = "Active"
    case receovered = "Recovered"
    case deceased = "Deceased"
}

enum BarTag: Int {
    case confirmed = 101
    case active = 201
    case receovered = 301
    case deceased = 401
}

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
    
    func getDateInStringFormat(requiredDateFormat:String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = requiredDateFormat
        return formatter.string(from: yourDate!)
        
    }
    func convertDateToString(inputDate: Int) -> String {
        let milisecond = inputDate
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM"
        return  dateFormatter.string(from: dateVar)
    }
}
