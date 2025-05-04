//
//  SearchResultsVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    enum Section {case main}

    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, MovieDetails>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow   
        configureTableView()
    }

    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

       
    }
}
extension SearchResultsVC:  UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        //cell.textLabel = "work"
        cell.imageView?.image = UIImage(systemName: "heart")
        return cell
    }
    
    
}
