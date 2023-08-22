//
//  HeroHeaderView.swift
//  Netflix_dj
//
//  Created by Dhananjay on 13/08/23.
//

import UIKit

class HeroHeaderView: UIView {
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    private let heroView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroView)
        addGradient()
        
        setUpButtonsStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroView.frame = bounds
    }
    
    func configureHeroImageView(with posterUrl: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterUrl)") else { return }
        heroView.sd_setImage(with: url)
    }
    
    func setUpButtonsStackView(){
        addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(downloadButton)
        
        let stackViewConstraints = [
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }

}
