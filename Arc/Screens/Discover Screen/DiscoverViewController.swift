//
//  ViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class DiscoverViewController: DataLoadingVC {
    var populerMovie: [Movie] = []
  
    
    var page :Int = 1
    
    lazy var collectionView : UICollectionView = {
        var cv  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        
        cv.register(SeactionHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: SeactionHeaderView.cellIdentifier)
     
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
        getMovies(page: 1)
    }
    
     func getMovies(page:Int){
        showLoadingView()
         Task{
             do {
                 let movies  =  try await NetworkManager.shared.getMovies(pageNumber: page)
                 updateUI(with:movies)
             }catch {
                 if let error = error  as? ErrorMassages {
                     presentAler(title: "Bad Stuff Happend", message: error.rawValue, buttonTile: "ok")
                 }else {
                     presentDefaultError()
                 }
             }
             dismissLoadingView()
         }
    }
    
    func updateUI(with movies :[Movie]) {
        print(movies)
        self.populerMovie.append(contentsOf: movies)
        print("\n\n\n\n\n\n\n")
        print(self.populerMovie)
        collectionView.reloadData()
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
