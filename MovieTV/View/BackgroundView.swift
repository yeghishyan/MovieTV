//
//  BackgroundView.swift
//  BritaliansTV
//
//  Created by miqo on 08.11.23.
//

import SwiftUI
import Kingfisher

struct BackgroundView: View {
    var currentItem: ItemModel?
    
    init(currentItem: ItemModel?) {
        self.currentItem = currentItem
    }
    
    var imagePath: String {
        if let currentItem = currentItem {
            return currentItem.backdropImage
        }
        
        return ""
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing, content: {            
            KFImage(URL(string: imagePath))
                .placeholder({ Image("backgroundImage") })
                .resizable()
                .frame(width: 1920, height: 1080)
            
            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom).zIndex(0)
            LinearGradient(colors: [.clear, .clear, .black], startPoint: .center, endPoint: .leading).zIndex(0)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .scaleEffect(0.6, anchor: .topTrailing)
    }
}
