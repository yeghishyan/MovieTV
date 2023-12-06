//
//  PageContentView.swift
//  BritaliansTV
//
//  Created by miqo on 11.11.23.
//

import SwiftUI


struct MainPageContent: View {
    @EnvironmentObject var mainPageVM: MainPageVM
    @EnvironmentObject var contentVM: ContentPageVM
    @EnvironmentObject var menuVM: MenuVM
    
    var focus: FocusState<MainPage.FocusFields?>.Binding
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            HighlightedView(currentItem: contentVM.focusedItem)
                .frame(maxWidth: 700, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
            collectionContentSection()
        }
        .padding(.top, 90)
        .foregroundStyle(.white, Color(hex: "#fff"))
    }
    
    func textColor(_ rowIndex: Int) -> Color {
        switch focus.wrappedValue {
        case .collection(let row, _):
            return row == rowIndex ? .white : .gray
        default: return .gray
        }
    }
    
    @ViewBuilder
    func collectionContentSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(Array(mainPageVM.rowData.enumerated()), id:\.offset) { (colIndex, item) in
                        CardItem(
                            imagePath: item.posterImage(size: .w342p),
                            size: TMDbImageSize.w342p.dimensions.applying(.init(scaleX: 0.75, y: 0.75)),
                            ifPressed: {
                                DispatchQueue.main.async {
                                    contentVM.selectedItem = item
                                }
                            }, ifFocused: {
                                DispatchQueue.main.async {
                                    contentVM.focusedItem = item
                                }
                            })
                        .focused(focus, equals: .collection(0, colIndex))
                    }
                }
                .padding(.top, 30)
                .padding(.leading, 30)
                .padding(.trailing, 200)
                
                Spacer()
            }
            .focusSection()
        }
    }
}
