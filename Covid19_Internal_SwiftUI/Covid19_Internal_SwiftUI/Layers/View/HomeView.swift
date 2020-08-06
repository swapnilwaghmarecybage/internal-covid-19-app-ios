//
//  HomeView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct HomeView: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @State private var selectionIndex = 0

    
    init() {
        viewModel = HomeTabViewModel()
    }
    
    var body: some View {
        ZStack{
            Color(Theme.backgroundColor)
            VStack {
                SegmentController(_index: $selectionIndex)
                HomeList(_viewModel: viewModel, _index: $selectionIndex)
            }
        }
    }
}
