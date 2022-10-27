//
//  DetailInfo.swift
//  Movie
//
//  Created by Дмитрий Супрун on 28.10.22.
//

import Foundation

/// Detail information about movie
struct DetailInfo: Decodable {
    let backdropPath: String
    let posterPath: String?
    let title: String
    let voteAverage: Double
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case overview
    }
}
