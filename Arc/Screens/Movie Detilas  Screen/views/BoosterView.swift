//
//  MovieBoosterView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class BoosterView: UIView {
    var movieBooster =  UIImageView()
    var layerbalckView =  UIView()
    
    var cellData: String? {
        didSet{
            guard let cellData else {return}
            Task {
                let fullImageURL = "https://image.tmdb.org/t/p/w500\(cellData)"
               let image = await NetworkManager.shared.downloadImage(from: fullImageURL)
                movieBooster.image = image
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(movieBooster)
        movieBooster.pinToEages(to: self)

        movieBooster.contentMode = .scaleAspectFill
        movieBooster.clipsToBounds = true
        
        movieBooster.addSubview(layerbalckView)
        layerbalckView.backgroundColor = .black.withAlphaComponent(0.1)
        layerbalckView.pinToEages(to: self)
    }
    

}

