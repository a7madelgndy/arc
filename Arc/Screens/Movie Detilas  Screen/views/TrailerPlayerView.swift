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
    private var playButton = MainButton(systemNameImage: "play.circle.fill", title: "Play", foregroundcolor: .systemPurple, backgroundColor: .systemPurple)
    
    weak var delegate : playTrailerDelegte?
    
    private var movieID: Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
         configurPlayButon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurPlayButon() {
        addSubview(playButton)
        playButton.pinToEdges(of: self)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    func set(movieID : Int){
        self.movieID = movieID
    }
     @objc private func playButtonTapped() {
         guard let movieID else {return}
         delegate?.didTappedPlayButton(movieID: movieID)
    }
}
