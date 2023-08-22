//
//  SearchResultsViewController.swift
//  Netflix_dj
//
//  Created by Dhananjay on 17/08/23.
//

import UIKit

class SearchResultsViewController: UIViewController{
    
    public var titles: [Title] = [Title]()
    
    weak var delegate: ShowTitlePreviewScreen?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 5, height: 200)
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = TitlePreviewViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        cell.configureImageView(with: titles[indexPath.item].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.item]
        guard let titleName = title.original_name ?? title.original_title else { return }
        
        APICaller.shared.getYoutubeTrailer(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                self.delegate?.didSelectMovieTitle(model: TitlePreviewViewModel(title: titleName, overview: title.overview ?? "", videoData: data, titleModel: title))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
