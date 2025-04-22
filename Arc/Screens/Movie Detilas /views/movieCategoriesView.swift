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
        sv.spacing = 8
        return sv
    }()
    
     var ratingSFsymbolImage  =  SFSymbolImageView(systemImage: "star.fill", tintColor: .systemPurple)
 
    var arrowSFsymbolImage = SFSymbolImageView(systemImage: "arrow.right", tintColor: .systemPurple)
   
    
    
    lazy var ratingTitle : UILabel = {
        let l = UILabel()
        l.textColor = .systemPurple
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false

        return l
    }()
    
    var releaseDate = BodyLabel(textAlignment: .left)
    
    
    lazy var languageTitle : UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.layer.borderWidth = 2
        l.layer.borderColor = UIColor.systemPurple.cgColor
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.setConstrains(paddingTop: 20)
        l.text = "Enlish"
        l.textColor = .systemPurple
        return l
    }()
    
    lazy var forAge: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.layer.borderWidth = 2
        l.layer.borderColor = UIColor.systemPurple.cgColor

        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "+13"
        l.textColor = .systemPurple
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurerStackView()
    
    }
    convenience init(rating:Float) {
        self.init(frame:.zero)
        ratingTitle.text = String(rating)
    }

    func configurerStackView() {
        stackView.addArrangedSubview(ratingSFsymbolImage)
        stackView.addArrangedSubview(ratingTitle)
        stackView.addArrangedSubview(arrowSFsymbolImage)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(languageTitle)
        stackView.addArrangedSubview(forAge)
        stackView.addArrangedSubview(emptyView)

        releaseDate.text = "2336"
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
