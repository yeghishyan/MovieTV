//
//  ContentPageVM.swift
//  BritaliansTV
//
//  Created by miqo on 08.11.23.
//

import SwiftUI

class ContentPageVM: ObservableObject {
    @Published var selectedItem: ItemModel? = nil
    @Published var focusedItem: ItemModel? = nil
}

