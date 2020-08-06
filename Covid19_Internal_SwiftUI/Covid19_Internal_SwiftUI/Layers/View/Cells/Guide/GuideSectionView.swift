//
//  GuideSectionView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 8/5/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import SwiftUI


struct GuideSectionView: View {
    private var color:Color
    private var title: String
    private var titleWidth: CGFloat
    private var sectionHeight: CGFloat
    
    init(_color:Color, _title: String, _titleWidth: CGFloat, _sectionHeight: CGFloat) {
        self.color = _color
        self.title = _title
        self.titleWidth = _titleWidth
        self.sectionHeight = _sectionHeight
    }
    
    var body: some View {
        ZStack{
            Color(Theme.backgroundColor)
            Text("")
                .frame(width: UIScreen.main.bounds.width, height:CGFloat(2))
                .foregroundColor(Color(Theme.labelColor))
                .background(self.color)
            
            Text(self.title)
                       .frame(width: self.titleWidth, height:self.sectionHeight , alignment: .center)
                       .foregroundColor(Color(Theme.labelColor))
                .background(self.color)

        }

        /*
        Text(self.title)
            .frame(width: self.titleWidth, height:self.sectionHeight , alignment: .center)
            .foregroundColor(Color(Theme.labelColor))
            .background(Color.red)
 */
        
    }
}

