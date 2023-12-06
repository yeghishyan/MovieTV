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
        VStack(alignment: .leading, spacing: 10) {
            HighlightedView(currentItem: contentVM.focusedItem)
                .frame(maxWidth: 600, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
            //if let _ = mainPageVM.rowData {
                collectionContentSection()
            //}
        }
        .padding(.top, 60)
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
                HStack(spacing: -5) {
                    ForEach(Array(mainPageVM.rowData.enumerated()), id:\.offset) { (colIndex, item) in
                        CardItem(
                            title: item.title,
                            imagePath: item.posterImage,
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
                .padding(.leading, 10)
                .padding(.trailing, 200)
                
                Spacer()
            }
            .focusSection()
        }
    }
}
