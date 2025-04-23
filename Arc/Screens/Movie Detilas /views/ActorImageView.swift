//
//  ActorImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class ActorImageView: UIImageView {
    //var cache            = NetworkManager.cache
    //var placeHolderImage = Images.placeHolderImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      =  true
        //contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromUrl url : String) {
        let endPoint = "https://image.tmdb.org/t/p/w92\(url)"
        Task {
            image  = await NetworkManager.shared.downloadImage(from: endPoint)
        }
      
    }
    
}
