//
//  Results.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation

/// Model List Movies
struct Results: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
