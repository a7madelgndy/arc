//
//  PopularCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let cellIdentifier = "PopularCollectionViewCell"
    
    private var imageTask: Task<(), Never>?
    
    lazy var moviePosterView: UIImageView = {
        let image =  UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        return image
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Configurtion
    private func configureUI() {
        addSubview(moviePosterView)
        
        moviePosterView.setConstrains(top: topAnchor ,
                                      leading: leadingAnchor ,
                                      bottom : bottomAnchor,
                                      trailing: trailingAnchor ,
                                      width: BannerSize.width,
                                      height: BannerSize.height)
        moviePosterView.backgroundColor = .systemGray6
    }
    
    
    // MARK: - Configure Cell
    func configuer(posterImagePath: String ) {
        
        if let image = ImageCacheManager.shared.image(for: posterImagePath) {
            moviePosterView.image = image
            
        }else {
            imageTask = Task {
                
                do {
                    if Task.isCancelled {return}
                    let image = await NetworkManager.shared.downloadImage(from: posterImagePath, imageQuality: .posterWidth342)
                    guard let image else {return}
                    moviePosterView.image = image
                    ImageCacheManager.shared.cache(image, forkey: posterImagePath)
                }
            }
        }
    }
    
    // MARK: - Reuse Handling
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterView.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
}
