//
//  MovieDescriptionViewController.swift
//  Movie
//
//  Created by Дмитрий Супрун on 27.10.22.
//

import UIKit

/// Detail information about movie
class MovieDescriptionViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let placeholderImageName = "photo"
        static let imagePath = "https://image.tmdb.org/t/p/w500"
        static let emptyName = ""
    }
    
    // MARK: - Private VisualComponents
    private let backDropImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.systemRed.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemRed.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 20
        return label
    }()
    
    private let ratingLabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.clipsToBounds = true
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60, weight: .bold, width: .expanded)
        label.text = "7.4"
        return label
    }()
    
    // MARK: - Public Properties
    var movie: Movie?
    var detailInfo: DetailInfo?
    
    // MARK: - Private Properties
    private var service = NetworkService()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDetailInfo()
    }
    
    // MARK: - Private Methods
    private func loadDetailInfo() {
        service.loadDetailInfo(id: movie?.id ?? 0) { [weak self] data in
            self?.detailInfo = data
            self?.backDropImageView.loadImage(
                urlName: Constants.imagePath + (self?.detailInfo?.backdropPath ?? Constants.emptyName)
            )
        }
        posterImageView.loadImage(urlName: Constants.imagePath + (movie?.posterPath ?? Constants.emptyName))
        ratingLabel.text = String(movie?.voteAverage ?? 0)
    }
}

// MARK: - SetupUI
private extension MovieDescriptionViewController {
    func setupUI() {
        view.backgroundColor = .systemOrange
        view.addSubview(backDropImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(posterImageView)
        view.addSubview(ratingLabel)
        backDropImageView.image = UIImage(systemName: Constants.placeholderImageName)
        descriptionLabel.text = movie?.overviewText
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = [
            backDropImageView,
            descriptionLabel,
            posterImageView,
            ratingLabel
        ]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            backDropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backDropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backDropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            backDropImageView.heightAnchor.constraint(equalToConstant: 200),
            
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            posterImageView.topAnchor.constraint(equalTo: backDropImageView.bottomAnchor, constant: 15),
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
            posterImageView.heightAnchor.constraint(equalToConstant: 160),
            
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ratingLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 15),
            ratingLabel.widthAnchor.constraint(equalToConstant: 120),
            ratingLabel.heightAnchor.constraint(equalToConstant: 160),
            
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor)
        ])
    }
}
