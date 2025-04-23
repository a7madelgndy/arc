//
//  CastCellCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class CastCell: UICollectionViewCell {
    static  let reuseIdentifier = "CastCell"
    
    lazy private var actorImageView = ActorImageView(frame: .zero)
    
    
    private var actorNameLable : UILabel = {
       let l = UILabel()
       l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
        addSubview(actorImageView)
        addSubview(actorNameLable)
        
        
        actorImageView.setConstrains(leading: leadingAnchor)
        actorImageView.setCenterX(inView: self)
        actorImageView.setDimensions(height: 30, width: 30)
        
        actorNameLable.setConstrains(leading: actorImageView.trailingAnchor , paddingLeft: 10)
        actorNameLable.setCenterX(inView: self)
        
    }
    
    func set(with actor : Actor) {
        actorImageView.downloadImage(fromUrl: actor.profile_path)
    }
}
