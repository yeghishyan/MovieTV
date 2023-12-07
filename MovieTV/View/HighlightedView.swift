//
//  HighlightedView.swift
//  BritaliansTV
//
//  Created by miqo on 10.11.23.
//

import SwiftUI
import Kingfisher

struct HighlightedView: View {
    private var currentItem: ItemModel?
    
    init(currentItem: ItemModel?) {
        self.currentItem = currentItem
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 10) {
                if let _ = currentItem {
                    titleSection()
                    infoSection()
                    descriptionSection()
                }
                Spacer()
            }
            .frame(maxWidth: 500, alignment: .topLeading)
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func titleSection() -> some View {
        ZStack {
            Text(currentItem!.title)
                .font(.raleway(size: 50, weight: .bold))
                .lineLimit(2).bold()
                .multilineTextAlignment(.leading)
        }
        .frame(maxHeight: 120, alignment: .topLeading)
    }
    
    @ViewBuilder
    private func infoSection() -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 30) {
                Text("TMDB \(String(format: "%.2f", currentItem!.vote_average))")
                    .font(.raleway(size: 30, weight: .bold))
                
                if currentItem!.adult {
                    Text("PG")
                        .overlay {
                            RoundedRectangle(cornerRadius: 1)
                                .inset(by: -3)
                                .stroke(lineWidth: 4)
                        }
                        .font(.raleway(size: 22, weight: .heavy))
                }
            }
            .frame(maxHeight: 60, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 30) {
                Text(currentItem!.genres!.joined(separator: " "))
                    .font(.raleway(size: 28, weight: .heavy))
                
            }
            .frame(maxHeight: 40, alignment: .topLeading)
        }
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Text(currentItem!.overview)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white.opacity(0.98))
                .font(.raleway(size: 22, weight: .regular))
        }
        .frame(maxWidth: 650, maxHeight: 200, alignment: .topLeading)
    }
}
