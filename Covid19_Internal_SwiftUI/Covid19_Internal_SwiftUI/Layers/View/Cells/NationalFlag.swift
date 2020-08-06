//
//  NationalFlag.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/31/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import SwiftUI

struct NationalFlag: View {
    
    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(Color(Theme.labelColor))
        
    }
}


class RemoteImageURL: ObservableObject {

    @Published var data = Data()
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else{ return }
         URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async { self.data = data }

            }.resume()
    }
    
}
