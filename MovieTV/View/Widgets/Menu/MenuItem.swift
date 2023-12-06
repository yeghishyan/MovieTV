//
//  MenuItems.swift
//  DemoApp
//
//  Created by miqo on 11.09.23.
//

import SwiftUI

enum MenuItem: Identifiable, CaseIterable, Hashable {
    case home
    case movies
    case series
    case settings
    case exit
    
    //case none
    
    var id: Int { hashValue }
    
    var name: String {
        switch self {
        case .home: return "Home"
        case .movies: return "Movies"
        case .series: return "Series"
        case .settings: return "Settings"
        case .exit: return "Exit"
        //default: return ""
        }
    }
    
    var image: String {
        return self.name
    }
}
