//
//  SearchViewController.swift
//  Netflix_dj
//
//  Created by Dhananjay on 31/07/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.searchController = searchController

        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

    func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchViewController: ShowTitlePreviewScreen{
    func didSelectMovieTitle(model: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
        
        guard let trimmedQuery = query,
              !trimmedQuery.trimmingCharacters(in: .whitespaces).isEmpty,
              trimmedQuery.trimmingCharacters(in: .whitespaces).count >= 3 else { return }
        guard let searchResultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        searchResultsController.delegate = self
        
        APICaller.shared.getSearchResults(query: trimmedQuery) { result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    searchResultsController.titles = titles
                    searchResultsController.searchResultsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return TitleTableViewCell() }
        cell.configure(with: TitleViewModel(posterUrl: titles[indexPath.row].poster_path ?? "", title: titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.item]
        guard let titleName = title.original_name ?? title.original_title else { return }
        
        APICaller.shared.getYoutubeTrailer(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, overview: title.overview ?? "", videoData: data, titleModel: title))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
