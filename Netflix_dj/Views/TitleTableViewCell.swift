//
//  TitleTableViewCell.swift
//  Netflix_dj
//
//  Created by Dhananjay on 17/08/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let titleImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let playImage = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30))
        button.setImage(playImage, for: .normal)
        button.tintColor = .white
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}
        
        titleImageView.sd_setImage(with: url)
        titleLabel.text = model.title
    }
    
    func applyConstraints(){
        let titleImageViewConstraints = [
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let playButtonConstraints = [
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(titleImageViewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
}
