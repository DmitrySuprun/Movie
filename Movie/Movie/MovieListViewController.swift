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
    }
    
    // MARK: - Private Visual Components
    private let movieListTableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Properties
    private func setupUI() {
        view.backgroundColor = .systemOrange
    }
    
    private func setupMovieListTableView() {
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
