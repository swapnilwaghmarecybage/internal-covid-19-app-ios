//
//  GuideRightHand.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 8/5/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import SwiftUI


struct GuideRightHandCell: View {
    
    private var title: String
    private var description: String
    private var imageName:String
    
    init(_title: String, _description: String, _imageName: String) {
        self.title = _title
        self.description = _description
        self.imageName = _imageName
    }
    var body: some View {
        
        HStack{
            
            VStack{
                Text(self.title)
                    .foregroundColor(Color(Theme.labelColor))
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth:.infinity ,alignment: .leading)
                    .padding(.all, CGFloat(10))
                                    
                Text(self.description)
                .foregroundColor(Color(Theme.labelColor))
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth:.infinity ,alignment: .leading)
                .padding(.all, CGFloat(10))

            }
            
            Image(self.imageName)
            .resizable()
                .frame(width: 85, height: 85, alignment: .center)
                .padding(.trailing, CGFloat(15))
                .cornerRadius(5)

           
        }.background(Color(Theme.highlightedColor))
        .cornerRadius(10)
        .padding(.top, CGFloat(5))
        .padding(.bottom, CGFloat(5))

    }
}

