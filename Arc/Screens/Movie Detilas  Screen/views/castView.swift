//
//  castView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class MovieCastView: UIView, UICollectionViewDelegate {
    var actors :[CastMember]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var collectionView:UICollectionView!
    private var rightchevronSF : SFSymbolImageView!
    
    private var framewidth : CGFloat = UIScreen.main.bounds.width
    private var didNotScrolled = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectoinView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCollectoinView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFourColumnFlowLayout(in: self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ActorCell.self , forCellWithReuseIdentifier: ActorCell.reuseIdentifier)
        
        addSubview(collectionView)
        
        collectionView.setConstrains(top: topAnchor , leading:  leadingAnchor , bottom: bottomAnchor)
        collectionView.setWidth(width: framewidth * 0.9)
        collectionView.pinToEdges(of: self)
    }
    
    
}

extension MovieCastView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.reuseIdentifier, for: indexPath) as? ActorCell else {
            fatalError("counde deque the cell")
        }
        guard let actors else {return cell }
        cell.set(with: actors[indexPath.row] )
        return cell
    }
    
    
   

}
