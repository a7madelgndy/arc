//
//  movieCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import UIKit

class movieCollectionViewCell: UICollectionViewCell {
    static  let reuseIdentifier = "searchCell"
    
    let imageView = DataLoadingImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(imageView)
        imageView.pinToEdges(of: contentView)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }
    
    func set(with  movie: Movie) {
        Task {
            let image = await NetworkManager.shared.downloadImage(from: movie.poster_path ?? "", imageQuality: .posterWidth92)
            imageView.image = image
        }
       
    }
}
