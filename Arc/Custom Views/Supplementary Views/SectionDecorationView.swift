//
//  SectionDecorationView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class SectionDecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    private func configure(){
        self.backgroundColor = .clear
        layer.cornerRadius = 20
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
