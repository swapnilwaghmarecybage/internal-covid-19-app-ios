//
//  ProtocolSelfAssistance.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

protocol SelfAssistanceManager {
    
    func updateArray(value:Int)
    func goBackCheckupDone()
    func sendDataToFirebase()
    func adduserAnswers(value: String)
}

