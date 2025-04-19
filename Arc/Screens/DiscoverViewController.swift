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
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
         configureConstrains()
        view.backgroundColor = .systemGray6
    }
    private func configureUI(){
        view.addSubview(collectionView)
    }
    private func configureConstrains() {
        view.addSubview(collectionView)
        collectionView.pinToEages(to: view)
    }


}
#Preview{
    TabBarController()
}
