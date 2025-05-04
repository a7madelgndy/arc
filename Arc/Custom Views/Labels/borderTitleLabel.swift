//
//  borderTitleLabel.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class borderTitleLabel: UILabel {
    
    var  borderColor : UIColor = Colors.main
    var textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(borderColor : UIColor){
        self.init(frame: .zero)
        self.borderColor = borderColor
    }
    
    //This is where the label actually draws the text.
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
    
    //This tells Auto Layout what size the label “wants” to be
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }
    
    
    private func configure() {
        textColor                         = Colors.main
        font                              = UIFont.systemFont(ofSize: 16, weight: .medium)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        textAlignment   = .center
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 5
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2
        
    }

}
