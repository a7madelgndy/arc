//
//  SFSymbolImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class SFSymbolImageView: UIImageView {
    
    
    private var systemImage :String?
    private var  forGroundcolor : UIColor?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 

    }
    
    convenience  init(systemImage: String , tintColor :UIColor) {
        self.init(frame: .zero)

        self.systemImage = systemImage
        self.forGroundcolor = tintColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let systemImage =   systemImage, let forGroundcolor = forGroundcolor else {return}
        image = UIImage(systemName: systemImage)
        contentMode = .scaleAspectFit
        tintColor = forGroundcolor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
