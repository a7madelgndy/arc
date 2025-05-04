//
//  movieCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import UIKit

class movieCollectionViewCell: UICollectionViewCell {
    static  let reuseIdentifier = "searchCell"
    
    private let moveiPosterImageView = DataLoadingImageView()
    
    private var imageTask: Task<(), Never>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(moveiPosterImageView)
        moveiPosterImageView.pinToEdges(of: contentView)
        moveiPosterImageView.layer.cornerRadius = 5
        moveiPosterImageView.clipsToBounds = true
    }
    
    func set(with  movie: Movie) {
        //is image in cache
        guard let moviePath = movie.poster_path else {return}
        if let image = ImageCacheManager.shared.image(for: moviePath) {
            moveiPosterImageView.image = image
            
        }else
        {
            imageTask = Task {
                if Task.isCancelled{return}
                let image = await NetworkManager.shared.downloadImage(from: moviePath, imageQuality: .posterWidth154)
                guard let image else {return}
                ImageCacheManager.shared.cache(image , forkey: moviePath)
                moveiPosterImageView.image = image
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        moveiPosterImageView.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
}
