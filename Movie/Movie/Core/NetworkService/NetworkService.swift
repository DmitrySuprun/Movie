//
//  NetworkService.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation

/// Network requests
final class NetworkService {
    // MARK: - Public Methods
    func loadPopularMovies(completion: @escaping(Results) -> ()) {
        loadData(url: MovieUrl.popularMovies, completion: completion)
    }
    
    func loadTopMovies(completion: @escaping(Results) -> ()) {
        loadData(url: MovieUrl.topMovies, completion: completion)
    }
    
    func loadUpComingMovies(completion: @escaping(Results) -> ()) {
        loadData(url: MovieUrl.upComing, completion: completion)
    }
    
    func loadDetailInfo(id: Int, completion: @escaping(DetailInfo) -> ()) {
        loadData(url: "\(MovieUrl.prefixUrlName)\(id)\(MovieUrl.postfixUrlName)", completion: completion)
    }
    
    // MARK: - Private Methods
    private func loadData<T: Decodable>(url: String, completion: @escaping (T) -> ()) {
        guard let url = URL(
            string: url)
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch {
                print(error)
            }
        }.resume()
    }
}
