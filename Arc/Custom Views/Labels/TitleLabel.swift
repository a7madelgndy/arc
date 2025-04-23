//
//  TitleLabel.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit


class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment : NSTextAlignment , fontsize: CGFloat){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .bold )
    }
    

    private func configure() {
        textColor                                 = .label
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.9
        lineBreakMode                             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
