//
//  movieCategoriesView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class movieCategoriesView: UIView {
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
    convenience init(rating:Float , language :  String , releadeData: String , isAdult: Bool) {
        self.init(frame:.zero)
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

    func configurerStackView() {
        stackView.addArrangedSubview(ratingSFsymbolImage)
        stackView.addArrangedSubview(ratingTitle)
        stackView.addArrangedSubview(arrowSFsymbolImage)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(languageTitle)
        stackView.addArrangedSubview(allowedAge)
        stackView.addArrangedSubview(emptyView)

    
        addSubview(stackView)
        stackView.pinToEages(to: self)
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}

#Preview {
    MovieDetilasVC()
}
