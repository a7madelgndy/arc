//
//  SearchResultsVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import UIKit

class SearchResultsVC: DataLoadingVC {
    
    //MARK: - UI components
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    //MARK: - Properties
    enum Section { case main }
    
    var movies: [Movie]? {
        didSet {
            guard let movies else { return }
            updateData(on: movies)
        }
    }
    
    private var isSearching = false
    private var isLoadMoreFollowers = false
    private var userQuery: String = " "
    
     //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    //MARK: -Configuration
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: MovieSearchCollectionViewCell.reuseIdentifier)
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        guard let movies else { return }
        
        if movies.isEmpty && !isSearching && !isLoadMoreFollowers {
            contentUnavailableConfiguration = UIHelper.canFindThisMovie(userSearch: userQuery)
            userQuery = " "
            
        } else if isSearching {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieSearchCollectionViewCell
            cell.set(with: movie)
            return cell
        }
    }
    
    
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    func updateWithUserQuery(searchFor: String) {
        userQuery = searchFor
        isLoadMoreFollowers = true
        isSearching = true
        Task {
            let movies = try await NetworkManager.shared.searchForAMovie(with: searchFor)
            self.movies = movies?.filter { $0.poster_path != nil }
            setNeedsUpdateContentUnavailableConfiguration()
            isSearching = false
            isLoadMoreFollowers = false
        }
    }
}

//MARK: CollectionViewDataSource
extension SearchResultsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieSearchCollectionViewCell else {
            fatalError("Cell could not be dequeued")
        }
        guard let movies else { fatalError("Movies data is nil") }
        cell.set(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieVc = MovieDetailsVC()
        guard let movieId = movies?[indexPath.row].id else { return }
        
        showLoadingView()
        Task {
            do {
                let movieDetails = try await NetworkManager.shared.getMovieDetails(with: movieId)
                movieVc.movieDetails = movieDetails
                present(movieVc, animated: true)
            } catch {
                presentDefaultError()
            }
            dismissLoadingView()
        }
    }
}
