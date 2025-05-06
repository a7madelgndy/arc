//
//  Button.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//
import UIKit

final class actionButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init( systemNameImage: UIImage , title: String = "" , foregroundcolor: UIColor , backgroundColor : UIColor = .clear){
        self.init(frame: .zero)
        self.configure( title: title,  systemNameImage: systemNameImage ,backgroundColor :backgroundColor, foregroundcolor : foregroundcolor )
    }
    
    
    private func configure() {
        configuration =  .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configure( title: String, systemNameImage: UIImage , backgroundColor : UIColor ,foregroundcolor: UIColor) {
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.baseForegroundColor = foregroundcolor
        configuration?.title = title
        
        configuration?.image = systemNameImage
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
    }
}

