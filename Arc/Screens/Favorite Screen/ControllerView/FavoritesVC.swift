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
    
    private var favoriteMovies: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            favoriteMovies = try coreData.getAllMovies()
        }catch{
            presentAler(title: .defualtOne , message: error.localizedDescription )
        }
        
        setNeedsUpdateContentUnavailableConfiguration()
        tableView.reloadData()
    }
    
    
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reusableidentifier)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pinToEages(to: view)

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
        
        guard let  movietitle = favoriteMovies?[indexPath.row].title else { fatalError("unable to guard the Movie ") }

        cell.configure(Title: movietitle, image: UIImage(systemName: "heart")!)
        
       return cell
        
    }  
}

