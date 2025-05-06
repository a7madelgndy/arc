//
//  ActorImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class ActorImageView: DataLoadingImageView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Configurtion
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      =  true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromUrl url : String) {
        Task {
            showSkeleton()
            image  = await NetworkManager.shared.downloadImage(from: url, imageQuality: .ActorImageWidth300)
            hideSkeleton()
        }
    }
}
