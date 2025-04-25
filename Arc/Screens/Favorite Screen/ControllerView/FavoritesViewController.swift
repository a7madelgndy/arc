//
//  FavoritesViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var tableView = UITableView()
    private var coreData = CoredataManager.shared
    
    private var favoriteMovies: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = coreData.getAllMovies()
        tableView.reloadData()
    }
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.id)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pinToEages(to: view)
        tableView.backgroundColor = .red
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}

        
        let movie = favoriteMovies?[indexPath.row]

        CoredataManager.shared.deleteData(MovieTitle: movie?.title ?? " ")
        favoriteMovies?.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.id) as! FavoriteCell? else {
            fatalError("unable to deque")
        }
        let movietitle = favoriteMovies?[indexPath.row].title
        cell.textLabel?.text = movietitle
       return cell
        
    }
    
    
}

