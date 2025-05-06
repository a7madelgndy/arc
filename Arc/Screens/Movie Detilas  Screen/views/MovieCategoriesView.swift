//
//  movieCategoriesView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class MovieCategoriesView: UIView {
    
    // MARK: - UI Elements
    lazy var emptyView =  UIView ()
    var stackView  =  UIStackView()
      
    var ratingIconImage  =  IconImageView(systemImage: SFSymbols.star, tintColor: Colors.main)
    var arrowIconImage = IconImageView(systemImage: SFSymbols.arrowRight, tintColor: Colors.main)
    var ratingLabel = BodyLabel()
    var releaseDateLabel = BodyLabel()
    var languageLabel = borderTitleLabel()
    var allowedAgelabel = borderTitleLabel()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurerStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuer(rating:Float , language:String ,releadeData:String , isAdult:Bool) {
        ratingLabel.text = String(rating)
        releaseDateLabel.text = String(releadeData.prefix(4))
        languageLabel.text = language
        ratingLabel.text =   String(format: "%.1f", rating)
        allowedAgelabel.text = isAdult ? "+13" :  "+18"
    }
    
    
    private func configurerStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 14
        
        let views = [ratingIconImage, ratingLabel, arrowIconImage, releaseDateLabel, languageLabel, allowedAgelabel, emptyView]
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        addSubview(stackView)
        stackView.pinToEdges(of: self)
    }
}
