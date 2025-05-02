//
//  BodyLabel.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit

class BodyLabel: UILabel {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment : NSTextAlignment = .left){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

    
    private func configure() {
        textColor                         = .label
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        numberOfLines                      = 9
        translatesAutoresizingMaskIntoConstraints = false
    }
}
