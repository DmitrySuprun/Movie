//
//  MovieListViewController.swift
//  Movie
//
//  Created by Дмитрий Супрун on 25.10.22.
//

import UIKit

/// Recommended movie list
class MovieListViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let aboutMovieCellID = "AboutMovieCellID"
        static let segmentControlItems = ["Top", "Popular", "Actual"]
    }
    
    // MARK: - Private Visual Components
    private let movieSegmentControl = {
        let segmentControl = UISegmentedControl(items: Constants.segmentControlItems)
        segmentControl.frame = CGRect(x: 0, y: 50, width: 393, height: 50)
        return segmentControl
    }()
    
    private let movieListTableView = {
        let tableView = UITableView()
        return tableView
    }()
    
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
        networkService.loadData { [weak self] data in
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
        movieListTableView.frame = CGRect(x: 0, y: 100, width: 393, height: 700)
    }
}
