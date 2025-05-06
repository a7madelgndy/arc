//
//  FavoritesViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let coreData = CoredataManager.shared
    private var favoriteMovies: [FavoriteMovieModel] = []
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
    }
    
    
    // MARK: - Private Methods
    
    private func loadFavorites() {
        do {
            favoriteMovies = try coreData.getAllMovies()
        }catch {
            presentDefaultError()
        }
        setNeedsUpdateContentUnavailableConfiguration()
        tableView.reloadData()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reusableidentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionIndexBackgroundColor = .clear
    }
    
    
    // MARK: - Empty Statue Handling
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        contentUnavailableConfiguration = favoriteMovies.isEmpty ?  UIHelper.createEmptyStateView() : nil
    }
}


// MARK: - UITableViewDataSource

extension FavoritesVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reusableidentifier) as! FavoriteCell? else {fatalError("unable to deque")}
        
        let movie = favoriteMovies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = favoriteMovies[indexPath.row]
        let favoritemovie = FavoriteMovieModel.getfavoritMovie(movie: movie)
     
        let detailsVC = MovieDetailsVC()
        detailsVC.movieFavoriteDetails = favoritemovie
        present(detailsVC, animated: true)
    }
}

    
// MARK: - UITableViewDelegate

extension FavoritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let alertVC = AlertVC(title: "Delete The  movie",
                              message: "Do you want to delete the movie?",
                              okButtonTitle: "Delete",
                              addCancelButton: true)
        
        alertVC.delegate = self
        alertVC.indexPath = indexPath.row
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC , animated: true)
    }
}

// MARK: - CancelButtonProtocol

extension FavoritesVC: CancelButtonProtocol {
    
    func didTappedOkButton(withIndexpath: Int) {
        let movieID = favoriteMovies[withIndexpath].id
        
        do {
            try self.coreData.deleteMovie(withID: movieID)
            self.favoriteMovies.remove(at: withIndexpath)
            self.setNeedsUpdateContentUnavailableConfiguration()
            tableView.reloadData()
        }catch{
            if let error = error as? ErrorMassages {
                self.presentAler(title: .defualtOne , message: error.rawValue)
            }
        }
    }
}
       
    

