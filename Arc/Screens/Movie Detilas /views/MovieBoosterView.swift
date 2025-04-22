//
//  MovieBoosterView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class MovieBoosterView: UIView {
    
    var backgroundMovieBooster =  UIImageView()
    var layerView =  UIView()
    //var mainMovieBooster = UIImageView()
    var cellData: String? {
        didSet{
            guard let cellData else {return}
            Task {
                let fullImageURL = "https://image.tmdb.org/t/p/w500\(cellData)"
               let image = await NetworkManager.shared.downloadImage(from: fullImageURL)
                let bulrImage = image?.blur(radius: 0)
                backgroundMovieBooster.image = bulrImage
               // mainMovieBooster.image = image
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         configure()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(backgroundMovieBooster)
        backgroundMovieBooster.pinToEages(to: self)
        backgroundMovieBooster.addSubview(layerView)
        backgroundMovieBooster.contentMode = .scaleAspectFill
        backgroundMovieBooster.clipsToBounds = true
    
        layerView.backgroundColor = .black.withAlphaComponent(0.5)
        
        
        layerView.pinToEages(to: self)
    }
    

}

