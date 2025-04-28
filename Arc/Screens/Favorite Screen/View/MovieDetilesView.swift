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
    private var titleSF = SFSymbolImageView(systemImage: "movieclapper", tintColor: .systemBlue.withAlphaComponent(0.5))
    private var title  = TitleLabel(textAlignment: .left, fontsize: 20)

    
    private var voteStackView = UIStackView()
    private var vote = UILabel()
    private var voteSF = SFSymbolImageView(systemImage: "star.fill", tintColor: .systemYellow.withAlphaComponent(0.5))
    
    private var releaseDataStackView = UIStackView()
    private var releaseDataSF = SFSymbolImageView(systemImage: "clock", tintColor: .systemRed.withAlphaComponent(0.5))
    private var releaseData = UILabel()
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleStackView ()
        configureVoteStackView()
        configureRealseDataStackView()
        configureUI()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(stackView)
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(voteStackView)
        stackView.addArrangedSubview(releaseDataStackView)
                
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        
        stackView.pinToEages(to: self)
        
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

        //title.setConstrains(leading: titleSF.trailingAnchor , trailing: trailingAnchor)
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
        vote.text = String(format: "%.1f",movie.vote_average)
        releaseData.text = String(movie.release_date.prefix(4))
        
    }
    
    

}
