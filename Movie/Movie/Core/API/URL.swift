//
//  URL.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation
/// URLS
enum Url {
    static let popularMovies = "https://api.themoviedb.org/3/movie/popular?api_key=300c9789c349380a810d91b042610da7&language=en-US&page=1"
    static let topMovies =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=300c9789c349380a810d91b042610da7&language=en-US&page=1"
    static let upComing =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=300c9789c349380a810d91b042610da7&language=en-US&page=1"
    static let prefixUrl = "https://api.themoviedb.org/3/movie/"
    static let postfixUrl = "?api_key=300c9789c349380a810d91b042610da7&language=en-US&page=1"
}
