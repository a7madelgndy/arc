//
//  SFSymbolImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class SFSymbolImageView: UIImageView {
    private var systemImageName :String?
    private var  forGroundcolor : UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience  init(systemImage: String , tintColor :UIColor) {
        self.init(frame: .zero)
        systemImageName = systemImage
        forGroundcolor = tintColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let systemImage =   systemImageName, let forGroundcolor = forGroundcolor else {return}
        image = UIImage(systemName: systemImageName ?? "person.crop.circle.badge.exclamationmark.fill")
        contentMode = .scaleAspectFit
        tintColor = forGroundcolor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
