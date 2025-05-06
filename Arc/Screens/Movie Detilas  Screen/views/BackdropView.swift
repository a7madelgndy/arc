//
//  MovieBoosterView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class BackdropView: UIView {
    
    // MARK: - UI Elements
    var BackdropImageView =  DataLoadingImageView()
    var layerbalckView =  UIView()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Confiuretoin
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(BackdropImageView)
        BackdropImageView.pinToEdges(of: self)
        
        BackdropImageView.contentMode = .scaleAspectFill
        BackdropImageView.clipsToBounds = true
        
        BackdropImageView.addSubview(layerbalckView)
        layerbalckView.backgroundColor = .black.withAlphaComponent(0.1)
        layerbalckView.pinToEdges(of: self)
    }
}

