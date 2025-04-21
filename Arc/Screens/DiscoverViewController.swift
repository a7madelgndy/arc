//
//  ViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class DiscoverViewController: DataLoadingVC {

    var populerMovie: [Movie]?
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task{
            do {
                showLoadingView()
                populerMovie = try await NetworkManager.shared.getMovies()
                collectionView.reloadData()
            }catch {
                if let error = error  as? ErrorMassages {
                    presentAler(title: "Bad Stuff Happend", message: error.rawValue, buttonTile: "ok")
                }else  {
                    presentDefaultError()
                }
            }
            dismissLoadingView()
        }
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
            case 0: AppLayouts.shared.populerMoviesSction()
            case 1: AppLayouts.shared.populerMoviesSction()
            default: AppLayouts.shared.populerMoviesSction()
            }
            
        }
        layout.register(SectionDecorationView.self
                        , forDecorationViewOfKind: "SectionBackground")
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

}

