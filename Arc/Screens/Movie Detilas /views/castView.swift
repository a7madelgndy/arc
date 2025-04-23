//
//  castView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class CastView: UIView, UICollectionViewDelegate {
    
    
    var actors :[CastMember]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var collectionView:UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectoinView()
        layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectoinView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFourColumnFlowLayout(in: self))
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ActorCell.self , forCellWithReuseIdentifier: ActorCell.reuseIdentifier)
        
        addSubview(collectionView)
        collectionView.pinToEages(to: self)


    }
}
extension CastView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print( actors?.count ?? 0)
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
