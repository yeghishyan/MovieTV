//
//  MovieSection.swift
//

import Foundation
import SwiftUI

struct MovieSection: Identifiable {
    let id = UUID()
    
    let movies: [ItemModel]
    //let endpoint: Endpoint
    //var title: String { endpoint.title() }
}

extension MovieSection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MovieSection, rhs: MovieSection) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MovieVideo: Codable, Identifiable {
    let id: String
    let name: String
    let site: String
    let key: String
    let type: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else { return nil }
        return URL(string: "https://youtube.com/embed/\(key)")
    }
}

struct MovieCast: Codable, Identifiable {
    let id: Int
    let character: String
    let name: String
    let profile_path: String?
}

struct MovieCrew: Codable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieCredit: Codable {
    var cast: [MovieCast]
    var crew: [MovieCrew]
}


struct MovieImages: Codable {
    struct ImageData: Codable, Identifiable {
        var id: String { file_path }
        let aspect_ratio: Float
        let file_path: String
        let height: Int
        let width: Int
    }
    
    let posters: [ImageData]?
    let backdrops: [ImageData]?
}

struct productionCountry: Codable, Identifiable {
    var id: String { name }
    let name: String
}
