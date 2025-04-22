//
//  MovieHeaderView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit
protocol FavoriteButtonDelegate:AnyObject {
    func didtapedFavoriteButton()
}
class MovieHeaderView: UIView {
    private var headerTitle = TitleLabel(textAlignment: .left, fontsize: 20)
    
    private var favoriteButton = Button(color: .systemBlue, title: "", systemNameImage: "heart")
    
    weak  var delegage : FavoriteButtonDelegate?
    var viewData: String? {
        didSet{
            guard let viewData else {return}
            Task {
                headerTitle.text = viewData
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         configure()
         configureButton()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(headerTitle)
        headerTitle.setCenterY(inView: self)
        headerTitle.setConstrains(leading: leadingAnchor,paddingLeft: 20 )
    }
    
    private func configureButton() {
        addSubview(favoriteButton)

        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20)
        ])
        favoriteButton.setConstrains(trailing:trailingAnchor , paddingLeft: 30)
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

    }
    @objc func favoriteButtonTapped() {
        favoriteButton = Button(color: .systemRed, title: "", systemNameImage: "heart.fill")
        delegage?.didtapedFavoriteButton()
    }
}

#Preview() {
    MovieDetilasVC()
}
