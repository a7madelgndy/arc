//
//  PopularCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    var cellData : MovieMockModel? {
        didSet{
            guard let cellData else {return}
            movieBannerView.image = UIImage(named: cellData.image)
            movieTitle.text = cellData.title
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
    
    private lazy var movieTitle : UILabel = {
        var title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        title.textAlignment = .center
        return title
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
        movieBannerView.setConstrains(top: topAnchor , leading: leadingAnchor , trailing: trailingAnchor , height: 100 )
        movieTitle.setConstrains(top: movieBannerView.bottomAnchor , leading: leadingAnchor , trailing: trailingAnchor, height: 30)
    }
    

}
