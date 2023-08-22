//
//  TitleCollectionViewCell.swift
//  Netflix_dj
//
//  Created by Dhananjay on 16/08/23.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let titleImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleImageView.frame = contentView.bounds
    }
    
    func configureImageView(with model: String){
//        print(model)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else { return }
        titleImageView.sd_setImage(with: url)
    }
}
