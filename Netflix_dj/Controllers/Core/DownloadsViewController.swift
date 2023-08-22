//
//  DownloadsViewController.swift
//  Netflix_dj
//
//  Created by Dhananjay on 31/07/23.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titlesItems: [TitleItem] = [TitleItem]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchDownloadedTitleItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func fetchDownloadedTitleItems(){
        DataPersistenceManager.shared.fetchDownloadedTitles { [weak self] result in
            switch result {
            case .success(let titleItems):
                self?.titlesItems = titleItems
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        
        guard let posterUrl = titlesItems[indexPath.row].poster_path else { return UITableViewCell()}
        guard let title = titlesItems[indexPath.row].original_title else { return UITableViewCell()}
        
        cell.configure(with: TitleViewModel(posterUrl: posterUrl, title: title))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteDownloadedTitle(with: titlesItems[indexPath.row]) { [weak self] result in
                switch result {
                case .success( _):
                    print("Deleted successfully")
                    self?.titlesItems.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return
        }
    }
}
