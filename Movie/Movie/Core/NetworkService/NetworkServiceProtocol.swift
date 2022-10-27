//
//  NetworkServiceProtocol.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation

/// Network Service Protocol
protocol NetworkServiceProtocol {
    func fetchPopularMoviesResult(completion: @escaping (Result<Results, Error>) -> Void)
}
