//
//  SegmentController.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct SegmentController: View {
    
    @Binding private var selectionIndex: Int
    
    init(_index: Binding<Int>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = Theme.highlightedColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: Theme.selectedSegmentControlColor], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: Theme.unSelectedSegmentControlColor], for: .normal)
        UISegmentedControl.appearance().frame.size.height = 200
        self._selectionIndex = _index
    }
 
    
    var body: some View {
        
        Picker(selection: $selectionIndex, label: Text("")) {
            Text("India").tag(0)
            Text("World").tag(1)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 1)
        )
            .frame(width:200, height: 100)
            .pickerStyle(SegmentedPickerStyle())
            .scaledToFit()
            .scaleEffect(CGSize(width: 1.7, height: 1.7))
        }
}
