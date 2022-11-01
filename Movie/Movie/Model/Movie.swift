//
//  Movie.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation

/// Movie  model
struct Movie: Decodable {
    let posterPath: String
    let overviewText: String
    let voteAverage: Double
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overviewText = "overview"
        case voteAverage = "vote_average"
        case id
        case title = "original_title"
    }
}
