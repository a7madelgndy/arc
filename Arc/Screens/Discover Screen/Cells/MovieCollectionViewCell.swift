//
//  PopularCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PopularCollectionViewCell"
    
    private var imageTask: Task<(), Never>?

    lazy var movieBannerView: UIImageView = {
        let image =  UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(movieBannerView)
        
        movieBannerView.setConstrains(top: topAnchor ,
                                      leading: leadingAnchor ,
                                      bottom : bottomAnchor,
                                      trailing: trailingAnchor ,
                                      width: BannerSize.width,
                                      height: BannerSize.height)
        movieBannerView.backgroundColor = .systemGray3
    }
    
    func configuer(posterImagePath: String ) {
        //w185 //w342 //w500//w780
        let fullImageURL:String = "https://image.tmdb.org/t/p/w500\(posterImagePath)"
        
        guard  let url = URL(string: fullImageURL) else {return}
        if let image = ImageCacheManager.shared.image(for: posterImagePath) {
            movieBannerView.image = image

        }else {
            imageTask = Task {
                do {
                    let (data, _ ) = try await URLSession.shared.data(from: url)
                    if Task.isCancelled {return}
                    if let image = UIImage(data: data){
                        movieBannerView.image = image
                        ImageCacheManager.shared.cache(image, forkey: posterImagePath)
                    }
                }catch {
                    print("failed to download The image")
                }
             }
        }

    }
    
    //Reste before implement to solve Flickerying 
    override func prepareForReuse() {
        super.prepareForReuse()
        movieBannerView.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
}
