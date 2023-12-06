//
//  SeasonContentPage.swift
//  BritaliansTV
//
//  Created by miqo on 11.11.23.
//

import SwiftUI

struct VideoPageContent: View {
    @EnvironmentObject var playerVM: PlayerVM
    @EnvironmentObject var contentVM: ContentPageVM
    
    @Binding var mediaItem: ItemModel?
    @FocusState var focus: String?
    @FocusState var isPlayFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HighlightedView(currentItem: contentVM.focusedItem)
                    .frame(maxWidth: 600, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            }
            .padding(.leading, 30)
            
            HStack {
                Button(action: {
                    //print("current Item link: ", contentVM.focusedItem)
                }, label: {
                    Label(title: {
                        Text("Play")
                            .font(.raleway(size: 27, weight: .bold))
                    }, icon: {
                        Image(systemName: "play.fill")
                            .padding(.leading, 20)
                            .imageScale(.large)
                    })
                    .frame(minWidth: 400, minHeight: 60, alignment: .leading)
                    .background(isPlayFocused ? .white : .black)
                    .foregroundStyle(isPlayFocused ? .black : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                })
                .focused($isPlayFocused)
                .buttonStyle(TvButtonStyle(border: 0))
                .padding([.leading, .bottom], 30)
                
                Spacer()
            }
            .focusSection()
            
//            if let _ = mediaItem {
//                collectionContentSection()
//            }
        }
        .defaultFocus($isPlayFocused, true)
        .foregroundStyle(.white, Color(hex: "#fff"))
//        .onChange(of: isPlayFocused, { _, newValue in
//            if newValue {
//                contentVM.selectedItem = mediaItem
//            }
//        })
//        .fullScreenCover(
//            item: $contentVM.videoItem,
//            onDismiss: {
//                playerVM.reset()
//            },
//            content: { item in
//                VideoPlayerView(url: URL(string: contentVM.videoItem!.link)!)
//            })
    }
    
//    @ViewBuilder
//    func collectionContentSection() -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            List(Array(mediaItem!.videoRow.enumerated()), id: \.offset, rowContent: { (rowIndex, row) in
//                LazyVStack {
//                    HStack {
//                        Text(row.title)
//                            .font(.raleway(size: 35, weight: .semibold))
//                            .foregroundStyle(.white)
//                            .padding(.leading, 10)
//                        Spacer()
//                    }
//                    
//                    ScrollView(.horizontal) {
//                        HStack(spacing: -5) {
//                            ForEach(Array(row.items.enumerated()), id:\.offset) { (colIndex, item) in
//                                CardItem(
//                                    title: item.title,
//                                    imagePath: item.poster,
//                                    ifPressed: {
//                                        print("focused Item: ", item.prettyPrint)
//                                    }, ifFocused: {
//                                        DispatchQueue.main.async {
//                                            contentVM.currentItem = item
//                                        }
//                                    })
//                                .focused($focus, equals: "\(rowIndex)_\(colIndex)")
//                            }
//                        }
//                        .padding(.trailing, 200)
//                        
//                        Spacer()
//                    }
//                    .focusSection()
//                }
//            })
//        }
//    }
}
