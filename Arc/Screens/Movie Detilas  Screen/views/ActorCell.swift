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
        l.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight, width: .standard)
       l.numberOfLines = 2
        l.textAlignment = .center
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
        actorImageView.setDimensions(height: 130, width: 130)
        
        actorNameLable.setConstrains(top:  actorImageView.bottomAnchor ,leading: leadingAnchor , trailing:  trailingAnchor , paddingTop: 5,paddingBottom:  10 )
   
        actorNameLable.setCenterX(inView: self)

    }
    
    func set(with actor : CastMember) {
        guard let path = actor.profile_path else {return}
        actorImageView.downloadImage(fromUrl: path)
        actorNameLable.text = actor.name
    }
    

}
