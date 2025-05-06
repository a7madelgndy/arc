//
//  TrailerPlayerView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

protocol playTrailerDelegte:AnyObject {
    func didTappedPlayButton(movieID: Int)
}

class TrailerPlayerView: UIView {
    
    // MARK: - UI Elements
    private var playButton = actionButton(systemNameImage: SFSymbols.playCircleFill, title: "Play", foregroundcolor: Colors.main, backgroundColor: Colors.main)
    
    // MARK: - Properties
    weak var delegate : playTrailerDelegte?
    private var movieID: Int?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
         configurePlayButon()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Confiuretoin
    private func configurePlayButon() {
        addSubview(playButton)
        playButton.pinToEdges(of: self)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    
    func set(movieID : Int){
        self.movieID = movieID
    }
    
    //MARK: Selectors
     @objc private func playButtonTapped() {
         guard let movieID else {return}
         delegate?.didTappedPlayButton(movieID: movieID)
    }
}
