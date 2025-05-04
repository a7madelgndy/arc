//
//  MovieDetileSView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 27/04/2025.
//

import UIKit

class MovieDetilesView: UIView {
    private var emptyView = UIView()
    
    private var titleStackView = UIStackView()
    private var titleSF = SFSymbolImageView(systemImage: SFSymbols.movieclapper , tintColor: .systemBlue.withAlphaComponent(0.5))
    private var title  = TitleLabel(textAlignment: .left, fontsize: 20)

    
    private var voteStackView = UIStackView()
    private var vote = UILabel()
    private var voteSF = SFSymbolImageView(systemImage: SFSymbols.star , tintColor: .systemYellow.withAlphaComponent(0.5))
    
    private var releaseDataStackView = UIStackView()
    private var releaseDataSF = SFSymbolImageView(systemImage: SFSymbols.clock, tintColor: .systemRed.withAlphaComponent(0.5))
    private var releaseData = UILabel()
    
    private let mainStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureUI(){
        configureMainStackView()
        
        configureTitleStackView ()
        configureVoteStackView()
        configureRealseDataStackView()
        
    }
    
    
    private func configureMainStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(mainStackView)
        
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(voteStackView)
        mainStackView.addArrangedSubview(releaseDataStackView)
                
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 10
        
        mainStackView.pinToEdges(of: self)
        
        for stackView in [titleStackView, voteStackView, releaseDataStackView] {
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.spacing = 5
        }
    }
    
    
    private func configureTitleStackView () {
        titleStackView.addArrangedSubview(titleSF)
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(emptyView)

        titleSF.setWidth(width: 20)
    }
    
    
    private func configureVoteStackView() {
        voteStackView.addArrangedSubview(voteSF)
        voteStackView.addArrangedSubview(vote)
        voteStackView.addArrangedSubview(emptyView)

        voteSF.setDimensions(height: 20, width: 20)
    }
    
    
    private func configureRealseDataStackView() {
        releaseDataStackView.addArrangedSubview(releaseDataSF)
        releaseDataStackView.addArrangedSubview(releaseData)
        releaseDataStackView.addArrangedSubview(emptyView)
        
        releaseDataSF.setDimensions(height: 20, width: 20)
    }
    
    
    func configureData(with movie: FavoriteMovieModel) {
        title.text = movie.title
        vote.text = String(format: "%.1f",movie.voteAverage)
        releaseData.text = String(movie.releaseDate.prefix(4))
        
    }
    
}
