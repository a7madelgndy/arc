//
//  ViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    lazy var collectionView : UICollectionView = {
        var cv  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.cellIdentifier)
        
        cv.register(PopulerHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: PopulerHeaderView.cellIdentifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
         configureConstrains()
         configureCompoitionalLayout()
        view.backgroundColor = .systemGray6
    }
    private func configureUI(){
        view.addSubview(collectionView)
    }
    private func configureConstrains() {
        view.addSubview(collectionView)
        collectionView.pinToEages(to: view)
    }

    private func configureCompoitionalLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex , enviorment in
            
            switch sectionIndex {
            default: AppLayouts.shared.populerMoviesSction()
            }
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

}

#Preview{
    TabBarController()
}
