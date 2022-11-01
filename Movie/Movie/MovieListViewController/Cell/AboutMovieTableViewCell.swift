//
//  AboutMovieTableViewCell.swift
//  Movie
//
//  Created by Дмитрий Супрун on 26.10.22.
//

import UIKit

// Short info about movie
final class AboutMovieTableViewCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let placeholderImageName = "photo"
        static let imagePath = "https://image.tmdb.org/t/p/w500"
        static let coderInitError = "init(coder:) has not been implemented"
    }
    // MARK: - Private Visual Components
    private let coverMovieImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemRed.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.coderInitError)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverMovieImageView.image = UIImage(systemName: Constants.placeholderImageName)
    }

    // MARK: - Public Methods
    func configure(movieName: String, imageName: String, rating: Double) {
        movieNameLabel.text = movieName
        ratingLabel.text = String(rating)
        coverMovieImageView.loadImage(
            urlName: Constants.imagePath + imageName)
    }
}

// MARK: - SetupUI
private extension AboutMovieTableViewCell {
    private func setupUI() {
        contentView.addSubview(coverMovieImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(ratingLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = [
            coverMovieImageView,
            movieNameLabel,
            ratingLabel
        ]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            coverMovieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coverMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coverMovieImageView.widthAnchor.constraint(equalToConstant: 120),
            coverMovieImageView.heightAnchor.constraint(equalToConstant: 160),

            contentView.bottomAnchor.constraint(equalTo: coverMovieImageView.bottomAnchor),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: coverMovieImageView.trailingAnchor),
            movieNameLabel.topAnchor.constraint(equalTo: coverMovieImageView.topAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            ratingLabel.leadingAnchor.constraint(equalTo: coverMovieImageView.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
