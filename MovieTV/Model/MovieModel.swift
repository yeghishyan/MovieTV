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
    func posterImage(size: TMDbImageSize = .w342p) -> String {
        return "https://image.tmdb.org/t/p/\(size.quality)/\(poster_path ?? "")"
    }
    
    func backdropImage(size: TMDbImageSize = .w1280b) -> String {
        return "https://image.tmdb.org/t/p/\(size.quality)/\(backdrop_path ?? "")"
    }
    
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

enum TMDbImageSize {
    case w92p
    case w154p
    case w185p
    case w342p
    case w500p
    
    case w300b
    case w1280b
    
    case w780p
    case w780b
    case originalP
    case originalB
    
    var quality: String {
        switch self {
        case .w92p: return "w92"
        case .w154p: return "w154"
        case .w185p: return "w185"
        case .w342p: return "w342"
        case .w500p: return "w500"
        case .w780p: return "w780"
        case .originalP: return "original"
            
        case .w300b: return "w300"
        case .w1280b: return "w1280"
        case .w780b: return "w780"
        case .originalB: return "original"
        }
    }
    
    var dimensions: CGSize {
           switch self {
           // Poster Dimensions
           case .w92p:
               return CGSize(width: 92, height: 138)
           case .w154p:
               return CGSize(width: 154, height: 231)
           case .w185p:
               return CGSize(width: 185, height: 278)
           case .w342p:
               return CGSize(width: 342, height: 513)
           case .w500p:
               return CGSize(width: 500, height: 750)
               
           // Backdrop Dimensions
           case .w300b:
               return CGSize(width: 300, height: 169)
           case .w1280b:
               return CGSize(width: 1280, height: 720)
           
           case .w780p:
               return CGSize(width: 780, height: 1170)
           case .w780b:
               return CGSize(width: 780, height: 439)
           
           case .originalB:
               return CGSize(width: 0, height: 0)
           case .originalP:
               return CGSize(width: 0, height: 0)

           }
       }
}
