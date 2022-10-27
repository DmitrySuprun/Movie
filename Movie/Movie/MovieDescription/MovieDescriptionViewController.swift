//
//  MovieDescriptionViewController.swift
//  Movie
//
//  Created by Дмитрий Супрун on 27.10.22.
//

import UIKit

/// Detail information about film
class MovieDescriptionViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let placeholderImageName = "photo"
        static let imagePath = "https://image.tmdb.org/t/p/w500"
    }
    
    // MARK: - Private VisualComponents
    private let posterImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 10
        return label
    }()
    
    // MARK: - Public Properties
    var movie: Movie?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension MovieDescriptionViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(posterImageView)
        view.addSubview(descriptionLabel)
        posterImageView.image = UIImage(systemName: Constants.placeholderImageName)
        posterImageView.loadImage(urlName: Constants.imagePath + (movie?.posterPath ?? ""))
        descriptionLabel.text = movie?.overviewText
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = [
            posterImageView,
            descriptionLabel
        ]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadMovieDescription(id: Int) {
        
    }
}
