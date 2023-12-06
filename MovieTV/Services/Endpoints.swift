//
//  Endpoints.swift
//  BritaliansTV
//
//  Created by miqo on 07.11.23.
//

import Foundation

enum Endpoint {
    case nowPlaying
    case discoverMovie
    case discoverTV

    case popular, topRated, upcoming, trending, genres
    case searchMovie
    case movieDetail(movie: Int)
    case recommended(movie: Int)
    case similar(movie: Int)
    case credits(movie: Int)
    case videos(movie: Int)
    case images(movie: Int)
    
    func path() -> String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .discoverMovie:
            return "discover/movie"
        case .discoverTV:
            return "discover/tv"
            
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .trending:
            return "trending/movie/day"
            
        case .genres:
            return "genre/movie/list"
        case .searchMovie:
            return "search/movie"
            
        case let .movieDetail(movie):
            return "movie/\(String(movie))"
        case let .videos(movie):
            return "movie/\(String(movie))/videos"
        case let .credits(movie):
            return "movie/\(String(movie))/credits"
        case let .recommended(movie):
            return "movie/\(String(movie))/recommendations"
        case let .similar(movie):
            return "movie/\(String(movie))/similar"
        case let .images(movie):
            return "movie/\(String(movie))/images"
        }
    }
}
