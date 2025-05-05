//
//  ViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class DiscoverViewController: DataLoadingVC {
    
    var populerMovies:[Movie] = []
    var upcommingMovies:[Movie] = []
    var topRatedMovies:[Movie] = []
    
    var page :Int = 1
    var ishiteApi:Bool = false
    
    private  let networkManager = NetworkManager.shared
    
    private var collectionView:UICollectionView!
    
    lazy var searchResultVc = SearchResultsVC()
    
    lazy var searchController: UISearchController = {
        let navControler = UINavigationController(rootViewController: searchResultVc)
        return UISearchController(searchResultsController: navControler)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureCollectionView()
         configureCompoitionalLayout()
         configerSearchController()
 
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ishiteApi {
            showSkeleton()
            getMovies(page: 1)
            ishiteApi.toggle()
        }
    }

    
    func configerSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search For A Movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
     func getMovies(page:Int){
         showLoadingView()
        
         DispatchQueue.global().asyncAfter(deadline: .now() + 3 , execute: { [weak self] in
             
             guard let self = self else {return }
             Task{
                 do {
                     let populerMovies  =  try await self.networkManager.getMovies(category: .populer , pageNumber: page)
                     let upcomingMovies = try await self.networkManager.getMovies(category: .upcomming , pageNumber: page)
                     let topRatedMovies = try await self.networkManager.getMovies(category: .TopRated , pageNumber: page)
                     self.hideSkeleton()
                     self.updateUI(with:populerMovies, upcomingMovies, topRatedMovies)
                 }catch {
                     if let error = error  as? ErrorMassages {
                         self.presentAler(title: .defualtOne , message: error.rawValue)
                     }else {
                         self.presentDefaultError()
                     }
                 }
                 self.dismissLoadingView()
             }
         }
         
         )
    }
    
    
    func updateUI(with movies :[Movie]...) {
        self.populerMovies.append(contentsOf: movies[0])
        self.upcommingMovies.append(contentsOf: movies[1])
        self.topRatedMovies.append(contentsOf: movies[2])
        collectionView.reloadData()
    }
    
    
    private func configureCollectionView() {
        collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)

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


extension DiscoverViewController:UISearchResultsUpdating {

     func updateSearchResults(for searchController: UISearchController) {
         guard let text = searchController.searchBar.text , (text != ""  && text.count > 1 )else {return}

         self.searchResultVc.updateWithUserQuery(searchFor: text.lowercased())
         
     }
    
    
}
