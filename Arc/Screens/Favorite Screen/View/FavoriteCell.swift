//
//  FavoriteCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 24/04/2025.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let  reusableidentifier:String = "FavoriteCell"
    
    private var movieTitle = UILabel()
    private var movieImage = UIImageView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        configureUI()
    }
    
    
    private func configureUI() {
        addSubViews(movieImage, movieTitle)
        
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        movieImage.setConstrains(top: topAnchor , leading:  leadingAnchor , bottom:  bottomAnchor)
        movieImage.setWidth(width: 100)
        movieImage.setHeight(height: 100)
        
        movieImage.layer.borderWidth = 3
        
        movieTitle.setConstrains(leading: movieImage.trailingAnchor)
        movieTitle.setCenterY(inView: self)
        
        movieTitle.layer.borderWidth = 3
    }
    
    
    func configure(Title:String ,image:UIImage) {
        movieImage.image = image
        movieTitle.text  = Title
    }
}
