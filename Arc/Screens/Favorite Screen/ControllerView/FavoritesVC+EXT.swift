//
//  FavoritesVC+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 26/04/2025.
//

import UIKit

extension FavoritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}

     
        do {
            try CoredataManager.shared.deleteMovie(withID: favoriteMovies?[indexPath.row].id ?? 3)
        }catch{
            if let error = error as? ErrorMassages {
                presentAler(title: "Some Thing Went Wrong", message: error.rawValue, buttonTile: "ok")
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.id) as! FavoriteCell? else {
            fatalError("unable to deque")
        }
        let movietitle = favoriteMovies?[indexPath.row].title
        cell.textLabel?.text = movietitle
       return cell
        
    }
    
    
}

