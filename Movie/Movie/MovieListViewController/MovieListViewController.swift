//
//  MovieListViewController.swift
//  Movie
//
//  Created by Дмитрий Супрун on 25.10.22.
//

import UIKit

/// Movie lists with base info
final class MovieListViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let aboutMovieCellID = "AboutMovieCellID"
        static let segmentControlItems = ["Top", "Popular", "UpComing"]
    }
    
    // MARK: - Private Visual Components
    private lazy var movieSegmentControl = {
        let segmentControl = UISegmentedControl(items: Constants.segmentControlItems)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(movieSegmentControlAction(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    private let movieListTableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Private Objc Properties
    @objc private func movieSegmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            networkService.loadPopularMovies { [weak self] data in
                self?.movies = data
                DispatchQueue.main.async {
                    self?.movieListTableView.reloadData()
                }
            }
        case 1:
            networkService.loadTopMovies { [weak self] data in
                self?.movies = data
                DispatchQueue.main.async {
                    self?.movieListTableView.reloadData()
                }
            }
        case 2:
            networkService.loadUpComingMovies { [weak self] data in
                self?.movies = data
                DispatchQueue.main.async {
                    self?.movieListTableView.reloadData()
                }
            }
        default: break
        }
    }
    
    // MARK: - Private Properties
    let networkService = NetworkService()
    var movies: Results?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMovieListTableView()
        loadData()
    }
    
    // MARK: - Private Methods
    private func loadData() {
        networkService.loadPopularMovies { [weak self] data in
            self?.movies = data
            DispatchQueue.main.async {
                self?.movieListTableView.reloadData()
            }
        }
    }
    
    private func setupMovieListTableView() {
        movieListTableView.register(AboutMovieTableViewCell.self,
                                    forCellReuseIdentifier: Constants.aboutMovieCellID)
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MovieDescriptionViewController()
        viewController.movie = movies?.results[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else { return 0 }
        return movies.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.aboutMovieCellID) as? AboutMovieTableViewCell
        else { return UITableViewCell() }
        guard let title = movies?.results[indexPath.row].title else { return UITableViewCell() }
        cell.configure(movieName: title,
                       imageName: movies?.results[indexPath.row].posterPath ?? "",
                       rating: movies?.results[indexPath.row].voteAverage ?? 0
        )
        return cell
    }
}

// MARK: - SetupUI
private extension MovieListViewController {
    func setupUI() {
        view.backgroundColor = .systemOrange
        view.addSubview(movieListTableView)
        view.addSubview(movieSegmentControl)
        addConstraints()
    }
    
    func addConstraints() {
        let views = [
            movieListTableView,
            movieSegmentControl
        ]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            movieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListTableView.topAnchor.constraint(equalTo: movieSegmentControl.bottomAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieSegmentControl.widthAnchor.constraint(equalToConstant: 250),
            movieSegmentControl.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
