//
//  CastCellCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    private var actorNameLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight, width: .standard)
        l.numberOfLines = 2
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    //MARK: - Properties
    static  let reuseIdentifier = "CastCell"
    
    private var imageTask: Task<(),Never>?
    lazy private var actorImageView = ActorImageView(frame: .zero)
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configuretion
    func configureUI() {
        contentView.addSubViews(actorImageView ,actorNameLabel)
        
        actorImageView.setConstrains(leading: leadingAnchor)
        actorImageView.setCenterY(inView: self)
        actorImageView.setDimensions(height: 130, width: 130)
        
        actorNameLabel.setConstrains(top:  actorImageView.bottomAnchor ,leading: leadingAnchor , trailing:  trailingAnchor , paddingTop: 5,paddingBottom:  10 )
        actorNameLabel.setCenterX(inView: self)
    }
    
    
    // MARK: - Configure Cell
    func set(with actor : CastMember) {
        actorNameLabel.text = actor.name
        //actor has no image
        guard let path = actor.profile_path else {
            actorImageView.image = SFSymbols.presonWithExclamationmark.withTintColor(.red)
            actorImageView.tintColor = .systemPurple.withAlphaComponent(0.5)
            return
        }
        
        //image is in Cache
        if let image = ImageCacheManager.shared.image(for: path ) {
            actorImageView.image = image
        }
        else {
            self.actorImageView.showSkeleton()
            if Task.isCancelled {return}
            imageTask = Task { actorImageView.downloadImage(fromUrl: path) }
        }
    }
    
    
    // MARK: - Reuse Handling
    override func prepareForReuse() {
        super.prepareForReuse()
        actorImageView.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
}

