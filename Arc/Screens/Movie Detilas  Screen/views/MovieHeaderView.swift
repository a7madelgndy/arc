//
//  MovieHeaderView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

protocol FavoriteButtonDelegate:AnyObject {
    func didtapedFavoriteButton(for movie : Movie? )
}

class MovieHeaderView: UIView {
    private var headerTitle = TitleLabel(textAlignment: .left, fontsize: 20)
    var favoriteButton = MainButton(color: .systemPurple, title: "", systemNameImage: "heart")
    
    weak  var delegage : FavoriteButtonDelegate?
    
    private var movie :Movie?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeaderTitle()
        configureFavoriteButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderTitle() {
        addSubview(headerTitle)
        headerTitle.setCenterY(inView: self)
        headerTitle.setConstrains(leading: leadingAnchor,paddingLeft: 20, width: UIScreen.main.bounds.width*0.7)
    }
    
    private func configureFavoriteButton() {
        addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20)
        ])
        
        favoriteButton.setConstrains(trailing:trailingAnchor , paddingLeft: 30)
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    
    func setheaderVeiw(with movie : Movie){
        self.movie = movie
        headerTitle.text =  movie.title
    }
    
    //MARK: Selectors
    @objc private func favoriteButtonTapped() {
        delegage?.didtapedFavoriteButton(for: movie)
    }
}
