//
//  GenresModel.swift
//  MovieTV
//
//  Created by miqo on 06.12.23.
//

import Foundation

struct MovieGenreListModel: Codable {
    let genres: [Genre]
    var genreMap: [Int: String] {
        return Dictionary(uniqueKeysWithValues: zip(genres.map{$0.id}, genres.map{$0.name}))
    }

    struct Genre: Codable {
        let id: Int
        let name: String

        enum CodingKeys: String, CodingKey {
            case id, name
        }
    }
}
