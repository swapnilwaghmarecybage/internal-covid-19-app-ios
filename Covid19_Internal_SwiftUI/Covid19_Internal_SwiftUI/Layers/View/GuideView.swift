//
//  GuideView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/28/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct GuideView: View {
    
    var body: some View {
        ZStack{
            Color(Theme.backgroundColor)
            
            List {
                Text("COVID common Symptoms")
                    .foregroundColor(Color(BarColors.confirmedColor))
                    .font(.system(size: 25, weight: .regular))
                HStack{
                    Image(uiImage: UIImage.gifImageWithName("light_fever") ?? UIImage())
                        .frame(maxWidth: .infinity, minHeight: 130)
                    Image(uiImage: UIImage.gifImageWithName("light_cough") ?? UIImage())
                        .frame(maxWidth: .infinity, minHeight: 130)
                    Image(uiImage: UIImage.gifImageWithName("light_tiredness") ?? UIImage())
                        .frame(maxWidth: .infinity, minHeight: 130)
                }.background(Color(Theme.highlightedColor))
                    .cornerRadius(10)
                
                Text("Less common Symptoms")
                    .foregroundColor(Color(BarColors.confirmedColor))
                    .font(.system(size: 25, weight: .regular))
                
                Text("\(Guide.lessCommonSymptoms)")
                    .foregroundColor(Color(Theme.labelColor))
                    .font(.system(size: 18, weight: .regular))
                    .lineSpacing(8)
                    .padding(.bottom, CGFloat(20))
                                    
                
                Section(header:GuideSectionView(_color: Color(BarColors.recoveredColor), _title: "Do's", _titleWidth: 80, _sectionHeight: 50) ) {
                    
                    GuideRightHandCell(_title: Guide.Dos[0].title, _description: Guide.Dos[0].description, _imageName: Guide.Dos[0].imageName)
                    .padding(.top, CGFloat(20))

                    GuideLeftHandCell(_title: Guide.Dos[1].title, _description: Guide.Dos[1].description, _imageName: Guide.Dos[1].imageName)
                    GuideRightHandCell(_title: Guide.Dos[2].title, _description: Guide.Dos[2].description, _imageName: Guide.Dos[2].imageName)
                    GuideLeftHandCell(_title: Guide.Dos[3].title, _description: Guide.Dos[3].description, _imageName: Guide.Dos[3].imageName)
                    .padding(.bottom, CGFloat(20))

                }
                
                Section(header: GuideSectionView(_color: Color(BarColors.activeColor), _title: "Dont's", _titleWidth: 100, _sectionHeight: 50)) {
                    
                    GuideRightHandCell(_title: Guide.Donts[0].title, _description: Guide.Donts[0].description, _imageName: Guide.Donts[0].imageName)
                    .padding(.top, CGFloat(20))
                    GuideLeftHandCell(_title: Guide.Donts[1].title, _description: Guide.Donts[1].description, _imageName: Guide.Donts[1].imageName)
                    GuideRightHandCell(_title: Guide.Donts[2].title, _description: Guide.Donts[2].description, _imageName: Guide.Donts[2].imageName)
                    GuideLeftHandCell(_title: Guide.Donts[3].title, _description: Guide.Donts[3].description, _imageName: Guide.Donts[3].imageName)
                    .padding(.bottom, CGFloat(20))

                }
                
                Section(header: GuideSectionView(_color: Color.purple, _title: "Psycological Guidelines", _titleWidth: 200, _sectionHeight: 50)) {
                    
                    Text("\(Guide.psycologicalGuidelines)")
                        .foregroundColor(Color(Theme.labelColor))
                        .font(.system(size: 18, weight: .regular))
                        .lineSpacing(5)
                        .padding(.top, CGFloat(20))
                    Divider()
                }

            }
        }
    }
}


