//
//  ContentView.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/14/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @State private var selection = 0
    
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Theme.labelColor]
        UINavigationBar.appearance().barTintColor = Theme.navogationBarbackgroundColor
        
        UITabBar.appearance().backgroundColor = Theme.highlightedColor
        UITabBar.appearance().barTintColor = Theme.highlightedColor
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Theme.backgroundColor).edgesIgnoringSafeArea(.all)
                    TabViewParent()
                    .navigationBarItems(trailing: RightBarButton())
                    .navigationBarTitle("\(App_Name)", displayMode: NavigationBarItem.TitleDisplayMode.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}























struct RightBarButton: View {
    @State private var isSheetShowing = false
    var body: some View {
        Button(action: {
            self.share()
            }) {
        Image("Share")
        }.foregroundColor(Color(Theme.labelColor))
    }
    
    func share(){
        self.isSheetShowing.toggle()
        let av =  UIActivityViewController(activityItems: ["https://developer.apple.com"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: false, completion: nil)
    }
}




