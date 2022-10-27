//
//  NetworkService.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import Foundation

/// Network requests
class NetworkService {
    
    func loadData(completion: @escaping (Results) -> ()) {
        guard let url = URL(
            string: Url.popularMovies)
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(Results.self, from: data)
                completion(model)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func loadImage(url: String, completion: @escaping(Data) -> ()) {
        let imageURL = "https://image.tmdb.org/t/p/w500" + url
        guard let validURL = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: validURL) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}
