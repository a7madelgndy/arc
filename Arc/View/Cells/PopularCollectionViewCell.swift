//
//  PopularCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PopularCollectionViewCell"
    
    var cellData : Movie? {
        didSet{
            guard let cellData else {return}
            print(cellData.poster_path)
        }
    }
    private lazy var movieBannerView: UIImageView = {
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(movieBannerView)
        //addSubview(movieTitle)
        movieBannerView.setConstrains(top: topAnchor , leading: leadingAnchor , bottom : bottomAnchor, trailing: trailingAnchor )
  
    }
    

}
