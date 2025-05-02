//
//  movieCategoriesView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class MovieCategoriesView: UIView {
    lazy var emptyView =  UIView ()
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 14
        return sv
    }()
    
    var ratingSFsymbolImage  =  SFSymbolImageView(systemImage: "star.fill", tintColor: .systemPurple)
    var arrowSFsymbolImage = SFSymbolImageView(systemImage: "arrow.right", tintColor: .systemPurple)
    var ratingTitle = BodyLabel()
    var releaseDate = BodyLabel()
    var languageTitle = borderTitleLabel()
    var allowedAge = borderTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurerStackView()
    }
    
    func configuer(rating:Float , language:String ,releadeData:String , isAdult:Bool) {
        ratingTitle.text = String(rating)
        releaseDate.text = String(releadeData.prefix(4))
        languageTitle.text = language
        ratingTitle.text =   String(format: "%.1f", rating)
        if isAdult {
            allowedAge.text = "+13"
        }else {
            allowedAge.text = "+18"
        }
    }
    private func configurerStackView() {
        let views = [ratingSFsymbolImage, ratingTitle, arrowSFsymbolImage, releaseDate, languageTitle, allowedAge, emptyView]
        for view in views {
            stackView.addArrangedSubview(view)
        }
        addSubview(stackView)
        stackView.pinToEdges(of: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
