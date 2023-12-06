//
//  Movie.swift
//

import Foundation

struct ItemModel: Codable, Identifiable {
    let id: Int
    
    let original_title: String
    let title: String
    
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Float
    let vote_average: Float
    let vote_count: Int
    
    let release_date: String?
    
    let runtime: Int?
    let status: String?
    let video: Bool
    
    var credits: MovieCredit?
    var videos: [MovieVideo]?
    
    var images: MovieImages?
    
    var production_countries: [productionCountry]?
    
    var character: String?
    var department: String?
    
    var genres: [MovieGenre]?
}

extension ItemModel {
    var posterImage: String { return "https://image.tmdb.org/t/p/original/\(poster_path ?? "")" }
    var backdropImage: String { return "https://image.tmdb.org/t/p/original/\(backdrop_path ?? "")" }
    
    var duration: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        guard let runtime = runtime else { return "n/a" }
        return formatter.string(from: TimeInterval(runtime)*60) ?? "n/a"
    }
    
    var releaseDate: Date {
        guard let date = release_date else { return Date() }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? Date()
    }
    
    var description: String {
        return ""
    }
    
    var directors: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "director" } }
    var producers: [MovieCrew]? { credits?.crew.filter { $0.job.lowercased() == "producer" } }
}

extension ItemModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
