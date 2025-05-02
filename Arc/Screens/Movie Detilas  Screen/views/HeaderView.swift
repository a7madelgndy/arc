//
//  MovieHeaderView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

protocol FavoriteButtonDelegate:AnyObject {
    func didtapedFavoriteButton()
    func shareSheetTaped()
}


class HeaderView: UIView {
    var title = TitleLabel(textAlignment: .left, fontsize: 20)
    
    var favoriteButton = MainButton(systemNameImage: "heart", foregroundcolor: .systemPurple)
    var shareSheetButton = MainButton(systemNameImage: "square.and.arrow.up", foregroundcolor: .systemPink)

    weak  var delegage : FavoriteButtonDelegate?
    
    private var movie :MovieDetails?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeaderTitle()
        configureFavoriteButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderTitle() {
        addSubview(title)
        title.setCenterY(inView: self)
        title.setConstrains(leading: leadingAnchor,paddingLeft: 20, width: UIScreen.main.bounds.width*0.7)
    }
    
    private func configureFavoriteButton() {
        addSubview(favoriteButton)
        addSubview(shareSheetButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20)
        ])
        
        favoriteButton.setConstrains(trailing:trailingAnchor , paddingLeft: 30)
        
        shareSheetButton.setCenterY(inView: self)
        shareSheetButton.setConstrains(trailing: favoriteButton.leadingAnchor)
        shareSheetButton.setDimensions(height: 40, width: 40)
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        shareSheetButton.addTarget(self, action: #selector(showActivityViewController), for:.touchUpInside)
    }
    
    
    func configureheaderVeiw(with movie : MovieDetails){
        self.movie = movie
        title.text =  movie.original_title

    }
    
    //MARK: Selectors
    @objc private func showActivityViewController() {
        delegage?.shareSheetTaped()
    }
    
    
    @objc private func favoriteButtonTapped() {
        delegage?.didtapedFavoriteButton()
    }
}
