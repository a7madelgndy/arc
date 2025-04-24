//
//  CastCellCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class ActorCell: UICollectionViewCell {
    static  let reuseIdentifier = "CastCell"
    
    lazy private var actorImageView = ActorImageView(frame: .zero)
    
    
    private var actorNameLable : UILabel = {
       let l = UILabel()
       l.font = UIFont.systemFont(ofSize: 10, weight: .medium)
       l.numberOfLines = 2
       l.translatesAutoresizingMaskIntoConstraints = false
       return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(actorNameLable)

        
        actorImageView.setConstrains(leading: leadingAnchor)
        actorImageView.setCenterY(inView: self)
        actorImageView.setDimensions(height: 50, width: 50)
        
        actorNameLable.setConstrains(leading: actorImageView.trailingAnchor , paddingLeft: 10)
        actorNameLable.setWidth(width: 50)
        actorNameLable.setCenterY(inView: self)

    }
    
    func set(with actor : CastMember) {
        guard let path = actor.profile_path else {return}
        actorImageView.downloadImage(fromUrl: path)
        actorNameLable.text = actor.name
    }
    

}
