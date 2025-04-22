//
//  BodyLabel.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit

class BodyLabel: UILabel {
    

    var textInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
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
    
    convenience init(textColor: UIColor , borderColor : UIColor){
        self.init(frame: .zero)
        self.textColor = textColor
        self.layer.borderColor = borderColor.cgColor
    }
    

    
    private func configure() {
        textColor                         = .secondaryLabel
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }


}
