//
//  FavoritesViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class FavoritesVC: DataLoadingVC {
    private var tableView = UITableView()
    
    private var coreData = CoredataManager.shared
    
    private var favoriteMovies: [FavoriteMovieModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            favoriteMovies = try coreData.getAllMovies()
        }catch {
            presentDefaultError()
        }
        
        setNeedsUpdateContentUnavailableConfiguration()
        tableView.reloadData()
    }
    
    
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reusableidentifier)
        
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        tableView.sectionIndexBackgroundColor = .clear
        
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        guard let favoriteMovies else {return}
        if favoriteMovies.isEmpty {
            contentUnavailableConfiguration = UIHelper.createEmptyStateView()
        }else {
            contentUnavailableConfiguration = nil
        }
    }
}


extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        do {
            try coreData.deleteMovie(withID: favoriteMovies?[indexPath.row].id ?? 3)
        }catch{
            if let error = error as? ErrorMassages {
                presentAler(title: .defualtOne , message: error.rawValue)
            }
        }
        
        favoriteMovies?.remove(at: indexPath.row)
        setNeedsUpdateContentUnavailableConfiguration()
        tableView.reloadData()
    }
}


extension FavoritesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reusableidentifier) as! FavoriteCell? else {
            fatalError("unable to deque")
        }
        
        guard let movie = favoriteMovies?[indexPath.row] else {fatalError("unable to guard the Movie")}
        
        cell.configure(with: movie)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = favoriteMovies?[indexPath.row] else {fatalError("Counden't guard the favorite movie")}
        let favoritemovie = FavoriteMovieModel(title: movie.title,
                                       id: movie.id,
                                       adult: movie.adult,
                                       originalLanguage: movie.originalLanguage,
                                       originalCountry: movie.originalCountry,
                                       overview: movie.overview,
                                       posterImage: movie.posterImage,
                                       releaseDate: movie.releaseDate,
                                       voteAverage:  movie.voteAverage,
                                       backdropImage: movie.backdropImage,
                                       runtime: movie.runtime)
        guard let f = favoritemovie.backdropImage else {
            
            return }
        let favoriteMovieVC = MovieDetilasVC()
         favoriteMovieVC.movieFavoriteDetails = favoritemovie
        present(favoriteMovieVC, animated: true)
    }
}
