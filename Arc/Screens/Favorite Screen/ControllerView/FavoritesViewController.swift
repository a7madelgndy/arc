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
    
    private var FavoriteMovies: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FavoriteMovies = coreData.getAllMovies()
    }
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.id)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.pinToEages(to: view)
        tableView.backgroundColor = .red
    }
}

extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FavoriteMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.id) as! FavoriteCell? else {
            fatalError("unable to deque")
        }
        var movietitle = FavoriteMovies?[indexPath.row].title
        cell.textLabel?.text = movietitle
       return cell
        
    }
    
    
}

