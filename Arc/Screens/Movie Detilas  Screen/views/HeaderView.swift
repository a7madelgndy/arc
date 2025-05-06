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
    
    // MARK: - UI Elements
    var titleLabel = TitleLabel(textAlignment: .left, fontsize: 20)
    var favoriteButton = MainButton(systemNameImage: SFSymbols.heart, foregroundcolor: Colors.main)
    var shareButton = MainButton(systemNameImage: SFSymbols.squareAndArrowUp, foregroundcolor: .systemPink)

    weak  var delegate : FavoriteButtonDelegate?
    private var movie :MovieDetails?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureHeaderTitle()
        configureFavoriteButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupViews() {
        addSubViews(titleLabel , favoriteButton , shareButton)
    }
    
    private func configureHeaderTitle() {
        titleLabel.setCenterY(inView: self)
        titleLabel.setConstrains(leading: leadingAnchor,paddingLeft: 20, width: UIScreen.main.bounds.width*0.7)
    }
    
    private func configureFavoriteButton() {
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20)
        ])
        
        favoriteButton.setConstrains(trailing:trailingAnchor , paddingLeft: 30)
        
        shareButton.setCenterY(inView: self)
        shareButton.setConstrains(trailing: favoriteButton.leadingAnchor)
        shareButton.setDimensions(height: 40, width: 40)
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(showActivityViewController), for:.touchUpInside)
    }
    
    
    func configureHeaderView(with movie : MovieDetails){
        self.movie = movie
        titleLabel.text =  movie.original_title

    }
    
    //MARK: Selectors
    @objc private func showActivityViewController() {
        delegate?.shareSheetTaped()
    }
    
    
    @objc private func favoriteButtonTapped() {
        delegate?.didtapedFavoriteButton()
    }
}
