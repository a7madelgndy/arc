//
//  SFSymbolImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class SFSymbolImageView: UIImageView {
    private var systemImage : UIImage?
    private var  forGroundcolor : UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience  init(systemImage: UIImage , tintColor :UIColor) {
        self.init(frame: .zero)
        self.systemImage = systemImage
        forGroundcolor = tintColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let systemImage =   systemImage, let forGroundcolor = forGroundcolor else {return}
        
        image = systemImage
        contentMode = .scaleAspectFit
        tintColor = forGroundcolor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
