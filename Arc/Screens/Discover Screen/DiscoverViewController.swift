//
//  ViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class DiscoverViewController: DataLoadingVC {
    internal var movies: [Movie] = []
   // var moviesToshow:[Movie] = []
    internal var page :Int = 1
    
    private  let networkManager = NetworkManager.shared
    
    private var collectionView:UICollectionView!
    
    let semaphore = DispatchSemaphore(value: 1)
    
    let myDispatch = DispatchQueue(label: "my dispatch")
    override func viewDidLoad() {
        super.viewDidLoad()
         configureCollectionView()
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
                 let movies  =  try await networkManager.getMovies(pageNumber: page)
                 updateUI(with:movies)
             }catch {
                 if let error = error  as? ErrorMassages {
                     presentAler(title: .defualtOne , message: error.rawValue)
                 }else {
                     presentDefaultError()
                 }
             }
             dismissLoadingView()
         }
    }
    
    
     func updateUI(with movies :[Movie]) {
        self.movies.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    
    private func configureCollectionView() {
        collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        
        view.addSubview(collectionView)
        collectionView.pinToEages(to: view)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.performBatchUpdates(nil, completion: nil)

        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        collectionView.register(SeactionHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: SeactionHeaderView.cellIdentifier)
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

