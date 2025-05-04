//
//  SearchResultsVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import UIKit

class SearchResultsVC: UIViewController{

    
    enum Section {case main}
    
    var movies :[Movie]? {
        didSet{
            guard let movies else {return}
            updataData(on: movies)
        }
    }
    
    
    private var collectionView: UICollectionView!
    
    private var dataSource:  UICollectionViewDiffableDataSource<Section, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow   
        configureCollectionView()
        ConfigureDataSouce()
    }

    func configureCollectionView() {
        collectionView =   UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view) )
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(movieCollectionViewCell.self, forCellWithReuseIdentifier: movieCollectionViewCell.reuseIdentifier)

       
    }
    func ConfigureDataSouce() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Movie> (collectionView: collectionView) { collectionView, indexPath, movie in
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCell.reuseIdentifier, for: indexPath) as! movieCollectionViewCell
            cell.set(with: movie)
            return cell
        }
    }
    
    
    func updataData(on movies:[Movie]){
      var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
      snapshot.appendSections([.main])
      snapshot.appendItems(movies)
      DispatchQueue.main.async {
          self.dataSource.apply(snapshot ,animatingDifferences: true)
        }
    }
    
    func updateWithText(searchFor : String) {
        print(searchFor)
        Task{
            movies = try  await NetworkManager.shared.searchForAMovie(with:searchFor)
        }
    }
}

extension SearchResultsVC: UICollectionViewDataSource , UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCell.reuseIdentifier, for: indexPath) as? movieCollectionViewCell else {fatalError("cant")}
        guard let movies else {fatalError("cant")}
        cell.set(with: movies[indexPath.row])
        return cell
    }
    
}
