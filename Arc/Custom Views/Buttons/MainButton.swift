//
//  Button.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//
import UIKit

final class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color : UIColor, title: String,  systemNameImage: String){
        self.init(frame: .zero)
        self.configure(color: color, title: title,  systemNameImage: systemNameImage )
    }
    
    private func configure() {
        configuration =  .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configure(color : UIColor , title: String, systemNameImage: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemNameImage)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
    }
}

