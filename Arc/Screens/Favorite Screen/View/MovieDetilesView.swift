//
//  MovieDetileSView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 27/04/2025.
//

import UIKit

class MovieDetilesView: UIView {
    
    // MARK: - UI Components
    
    private var emptyView = UIView()
    
    private var titleStackView = UIStackView()
    private var titleIcon = SFSymbolImageView(systemImage: SFSymbols.movieclapper , tintColor: .systemBlue.withAlphaComponent(0.5))
    private var titleLabel  = TitleLabel(textAlignment: .left, fontsize: 20)

    private var voteStackView = UIStackView()
    private var voteLabel = UILabel()
    private var voteIcon = SFSymbolImageView(systemImage: SFSymbols.star , tintColor: .systemYellow.withAlphaComponent(0.5))
    
    private var releaseDateStackView = UIStackView()
    private var releaseDateIcon = SFSymbolImageView(systemImage: SFSymbols.clock, tintColor: .systemRed.withAlphaComponent(0.5))
    private var releaseDateLabel = UILabel()
    
    private let mainStackView = UIStackView()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configuration
    
    func configureUI(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        
        configureStackViews()
        configureMainStackView()
    }
    
    
    private func configureStackViews() {
        // Title Stack
        titleStackView.addArrangedSubview(titleIcon)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(emptyView)
        titleIcon.setWidth(width: 20)
        
        // Vote Stack
        voteStackView.addArrangedSubview(voteIcon)
        voteStackView.addArrangedSubview(voteLabel)
        voteStackView.addArrangedSubview(emptyView)
        voteIcon.setDimensions(height: 20, width: 20)
        
        // Release Date Stack
        releaseDateStackView.addArrangedSubview(releaseDateIcon)
        releaseDateStackView.addArrangedSubview(releaseDateLabel)
        releaseDateStackView.addArrangedSubview(emptyView)
        releaseDateIcon.setDimensions(height: 20, width: 20)
    }
    
    
    private func configureMainStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(voteStackView)
        mainStackView.addArrangedSubview(releaseDateStackView)
                
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 10
        
        mainStackView.pinToEdges(of: self)
        
        //apply same layout to all child stack views
        [titleStackView, voteStackView, releaseDateStackView].forEach{
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.spacing = 5
        }
    }
    
    
    func configureData(with movie: FavoriteMovieModel) {
        titleLabel.text = movie.title
        voteLabel.text = String(format: "%.1f",movie.voteAverage)
        releaseDateLabel.text = String(movie.releaseDate.prefix(4))
    }
}
