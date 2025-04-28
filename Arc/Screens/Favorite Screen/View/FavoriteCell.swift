//
//  FavoriteCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 24/04/2025.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let  reusableidentifier:String = "FavoriteCell"
    
    private var movieDetilesView = MovieDetilesView()
    private var movieImage = CornerImageView(frame: .zero)
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    
    private func configureUI() {
        addSubViews(movieImage, movieDetilesView)
        
        
        movieImage.setConstrains(top: topAnchor , leading:  leadingAnchor , bottom:  bottomAnchor,paddingLeft: 10 ,paddingBottom: 10,paddingRight: 10 )
        
        movieImage.setWidth(width: 100)
        movieImage.setHeight(height: 100*(3/2))
        
        
        movieDetilesView.setConstrains(leading: movieImage.trailingAnchor, trailing: trailingAnchor ,paddingLeft: 10,paddingRight: 20)
        
        movieDetilesView.setCenterY(inView: self)
    }
    
    
    func configure(with movie: FavoriteMovieModel) {
        movieImage.image = movie.posterImage
        movieDetilesView.configureData(with: movie)
    }
}
