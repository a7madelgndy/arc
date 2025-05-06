//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetailsVC: DataLoadingVC {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var backdropView = BackdropView()
    private var headerView = HeaderView()
    private var categoriesView = MovieCategoriesView()
    private var playTailerView = TrailerPlayerView()
    private var movieOverview = BodyLabel()
    private var movieCastView = MovieCastView()
    
    // MARK: - Properties
    private var coredataManager = CoredataManager.shared
    private var castMembers:[CastMember]?
    private var backdropImage:UIImage?
    
    //Use it if you make api call
    var movieDetails : MovieDetails? {
        didSet {
            guard let movieDetails else {return}
            fetchMovieData()
            assignDataToViews()
            configuerFavoriteButton(with: movieDetails.id)
        }
    }
    
    //Use it if you deal with coredate
    var movieFavoriteDetails : FavoriteMovieModel? {
        didSet{
            guard let movieFavoriteDetails else {return}
            configureWithFavoriteMovie(favoriteMovie: movieFavoriteDetails)
            configuerFavoriteButton(with: movieFavoriteDetails.id)
        }
    }
    
    
    var posterImage:UIImage?
    
    private lazy var shareSheet = UIActivityViewController(activityItems: [moviUrl!],applicationActivities:  nil)
    private let moviUrl = URL(string: "IMDB")
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupConstrains()
    }
    
    //////////////////
    func setWithFavoriteMovie(favoriteMovie: FavoriteMovieModel ){
        backdropView.BackdropImageView.image = favoriteMovie.backdropImage
    }
    
    //MARK: CoreData
    private func isMovieInCoreData(movieId : Int)-> Bool? {
        do{
            return  try coredataManager.checkForMovie(with: movieId )
        }catch {
            presentAler(title: .defualtOne , message: error.localizedDescription )
            return nil
        }
    }
    
    
    private func configuerFavoriteButton(with movieId : Int) {
        guard let isFavorite = isMovieInCoreData(movieId: movieId)  else {return}
        
        let image = isFavorite ? SFSymbols.heartFill : SFSymbols.heart
        headerView.favoriteButton.configuration?.image = image
    }
    
    
    //MARK: Data fetching
    func fetchMovieData() {
        guard let movieDetails else {return}
        fetchBackdropImage(with: movieDetails.backdrop_path ?? " ")
        fetchCastMemberData(with: movieDetails.id)
    }
    
    
    private func fetchBackdropImage(with path: String)  {
        Task {
            backdropImage = await NetworkManager.shared.downloadImage(from: path, imageQuality: .ActorImageWidthw1280)
            if let backdropImage {
                backdropView.BackdropImageView.image = backdropImage
            }
        }
    }
    
    
    private func fetchCastMemberData(with movieID : Int) {
        Task{
            do {
                castMembers = try await NetworkManager.shared.getMovieCast(movieId: String(movieID))
                movieCastView.actors = self.castMembers
            }catch {
                print("can not get cast member data ")
            }
        }
    }
    
    
    //MARK: View configuration
    private func assignDataToViews() {
        guard let movieDetails else {return}
        headerView.configureHeaderView(with: movieDetails)
        headerView.delegate = self
        
        categoriesView.configuer(rating: Float(movieDetails.vote_average),
                                 language: movieDetails.original_language,
                                 releadeData: movieDetails.release_date,
                                 isAdult: movieDetails.adult)
        
        fetchCastMemberData(with: movieDetails.id)
        movieOverview.text = movieDetails.overview
    }
    
    
    private func configureWithFavoriteMovie(favoriteMovie : FavoriteMovieModel) {
        backdropView.BackdropImageView.image = favoriteMovie.backdropImage
        headerView.titleLabel.text = favoriteMovie.title
        
        categoriesView.configuer(rating: favoriteMovie.voteAverage, 
                                 language: favoriteMovie.originalLanguage,
                                 releadeData: favoriteMovie.releaseDate,
                                 isAdult: favoriteMovie.adult)
        
        movieOverview.text = favoriteMovie.overview
        fetchCastMemberData(with: favoriteMovie.id)
    }
    
    // MARK: - Layout
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
    
    private func setupConstrains() {
        contentView.addSubViews(backdropView, headerView, playTailerView, movieOverview, movieCastView,categoriesView)
        
        backdropView.setConstrains(top: contentView.topAnchor,
                                   leading: contentView.leadingAnchor,
                                   trailing:  contentView.trailingAnchor,
                                   height: UIScreen.main.bounds.width*1/2)
        
        headerView.setConstrains(top: backdropView.bottomAnchor,
                                 leading:  contentView.leadingAnchor,
                                 trailing: contentView.trailingAnchor,
                                 paddingTop: 10,
                                 height: 50)
        
        
        categoriesView.setConstrains(top:headerView.bottomAnchor,
                                     leading: contentView.leadingAnchor,
                                     trailing: contentView.trailingAnchor,
                                     paddingTop: 10,
                                     paddingLeft: 20,
                                     paddingRight: 20,
                                     height: 40)
        
        playTailerView.setConstrains(top:categoriesView.bottomAnchor,
                                     leading: contentView.leadingAnchor,
                                     trailing: contentView.trailingAnchor,
                                     paddingTop: 10,
                                     paddingLeft: 20,
                                     paddingRight: 20,
                                     height: 40)
        playTailerView.delegate = self
        playTailerView.set(movieID: movieDetails?.id ?? 0)
        
        movieOverview.setConstrains(top: playTailerView.bottomAnchor,
                                    leading: contentView.leadingAnchor,
                                    trailing: contentView.trailingAnchor,
                                    paddingTop:  10,
                                    paddingLeft:  20,
                                    paddingRight: 20  )
        
        movieOverview.autoresizingMask = .flexibleHeight
        
        movieCastView.setConstrains(top: movieOverview.bottomAnchor,
                                    leading: contentView.leadingAnchor,
                                    trailing: contentView.trailingAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 20,
                                    paddingRight: 20,
                                    height: 220)
    }
}


// MARK: - FavoriteButtonDelegate
extension MovieDetailsVC:FavoriteButtonDelegate {
    
    func shareSheetTaped() {
        present(shareSheet , animated: true)
    }
    
    
    func didtapedFavoriteButton() {
        guard let movieDetails else {return}
        
        do {
            let isFavorite = try coredataManager.checkForMovie(with: movieDetails.id)
            if isFavorite {
                try  coredataManager.deleteMovie(withID: movieDetails.id)
            }
            else {
                guard let backdropImage else { return }
                try coredataManager.save(withMovie: movieDetails, backdropImage: backdropImage)
                presentAler(title: .success, message: "Successfully added to Favorites 🎉", buttonTitle: "Hooray!")
            }
            configuerFavoriteButton(with: movieDetails.id)
        }catch {
            if let error = error as? ErrorMassages {
                presentAler(title: .defualtOne, message: error.rawValue)
            }
        }
    }
}



// MARK: - playTrailerDelegate
extension MovieDetailsVC:playTrailerDelegte {
    func didTappedPlayButton(movieID: Int) {
        Task {
            showLoadingView()
            defer {dismissLoadingView()}
            
            do{
                guard let youtubeLink = try await NetworkManager.shared.getMovieTrailerURL(movieID: movieID) else {return }
                pressenSafrieVC(with: youtubeLink)
                
            }catch {
                if let error = error as? ErrorMassages {
                    presentAler(title: .defualtOne , message: error.rawValue)
                }
            }
        }
    }
}




