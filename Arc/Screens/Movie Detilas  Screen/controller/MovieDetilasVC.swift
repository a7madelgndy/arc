//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetilasVC: DataLoadingVC {
    //MARK: Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    var backdropView = BackdropView()
    var headerView = HeaderView()
    var categroiesView = MovieCategoriesView()
    var playTailerView = TrailerPlayerView()
    var movieOverview = BodyLabel()
    var movieCastView = MovieCastView()
    
    var castMembers:[CastMember]?
    
    var backdropImage:UIImage?
  
    var movieDetails : MovieDetails? {
        didSet {
            guard let movieDetails else {return}
            getdataForApi()
            assignDataToViews()
            configuerButton(with: movieDetails.id)
        }
    }
    
    var movieFavoriteDetails : FavoriteMovieModel? {
        didSet{
            guard let movieFavoriteDetails else {return}
            convertToMovieDettails(favoriteMovie: movieFavoriteDetails)
            configuerButton(with: movieFavoriteDetails.id)

        }
    }
    
    var posterImage:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureScrollView()
        configureConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
 
    
   
    func setWithFavoriteMovie(favoriteMovie: FavoriteMovieModel ){
        backdropView.BackdropImageView.image = favoriteMovie.backdropImage        
    }
    
    let moviUrl = URL(string: "MovieUrl")
    lazy var sharSheet = UIActivityViewController(activityItems: [moviUrl!],applicationActivities:  nil)
     //MARK: Dealing With CoreData
    private func checkIsMovieIncordate(movieId : Int)-> Bool? {
       do{
           let  isInCoreData = try CoredataManager.shared.checkForMovie(with: movieId )
           return isInCoreData
       }catch {
           presentAler(title: .defualtOne , message: error.localizedDescription )
       }
       
       return nil
   }
    private func configuerButton(with movieId : Int) {
        guard let isMovieINcoreData = checkIsMovieIncordate(movieId: movieId)  else {return}
        
        if isMovieINcoreData {
            headerView.favoriteButton.configuration?.image = UIImage(systemName: "heart.fill")
        }else {
            headerView.favoriteButton.configuration?.image = UIImage(systemName: "heart")
        }
}
    
    
   
    //MARK: Get from  api
    
    func getdataForApi() {
        guard let movieDetails else {return}
        getBackdropImage(with: movieDetails.backdrop_path!)
        getCastMemberData(with: movieDetails.id)
    }
    
    private func getBackdropImage(with path: String)  {
        DispatchQueue.main.async {
            self.backdropView.BackdropImageView.showSkeleton()
        }

        Task { @MainActor in
            backdropImage = await NetworkManager.shared.downloadImage(from: path)
            guard let backdropImage else {return}
            backdropView.BackdropImageView.image = backdropImage
            backdropView.BackdropImageView.hideSkeleton()

        }
    }
    
    private func getCastMemberData(with movieID : Int) {
        Task{
            do {
                castMembers = try await NetworkManager.shared.getMovieCast(movieId: String(movieID))
            }catch {
                print("can not get cast member data ")
            }
            movieCastView.actors = self.castMembers
        }
    }
    
    //MARK: configuration methouds
    
    private func assignDataToViews() {
        guard let movieDetails else {return}
        headerView.configureheaderVeiw(with: movieDetails)
        headerView.delegage = self
     
        categroiesView.configuer(rating: Float(movieDetails.vote_average), language: movieDetails.original_language, releadeData: movieDetails.release_date, isAdult: movieDetails.adult)
    
        //getCastMemberData(with: movieDetails.id)
        
        movieOverview.text = movieDetails.overview
    }
    
    private func convertToMovieDettails(favoriteMovie : FavoriteMovieModel) {
        backdropView.BackdropImageView.image = favoriteMovie.backdropImage
        headerView.title.text = favoriteMovie.title
        categroiesView.configuer(rating: favoriteMovie.voteAverage, language: favoriteMovie.originalLanguage, releadeData: favoriteMovie.releaseDate, isAdult: favoriteMovie.adult)
        movieOverview.text = favoriteMovie.overview
        
    }
    private func configureScrollView() {
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
    
    private func configureConstrains() {
        contentView.addSubViews(backdropView, headerView, playTailerView, movieOverview, movieCastView,categroiesView)

        backdropView.setConstrains(top: contentView.topAnchor , leading: contentView.leadingAnchor, trailing:  contentView.trailingAnchor , height: UIScreen.main.bounds.width*1/2)
        
        headerView.setConstrains(top: backdropView.bottomAnchor , leading:  contentView.leadingAnchor , trailing: contentView.trailingAnchor ,paddingTop: 10, height: 50)
        
        
        categroiesView.setConstrains(top:headerView.bottomAnchor , leading: contentView.leadingAnchor,trailing: contentView.trailingAnchor , paddingTop: 10 , paddingLeft: 20,paddingRight: 20 , height: 40)
        
        playTailerView.setConstrains(top:categroiesView.bottomAnchor , leading: contentView.leadingAnchor , trailing: contentView.trailingAnchor , paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 , height: 40)
        playTailerView.delegate = self
        playTailerView.set(movieID: movieDetails?.id ?? 0)
        
        movieOverview.setConstrains(top: playTailerView.bottomAnchor , leading: contentView.leadingAnchor , trailing: contentView.trailingAnchor , paddingTop:  10 , paddingLeft:  20 , paddingRight: 20  )
        movieOverview.autoresizingMask = .flexibleHeight
        
        movieCastView.setConstrains(top: movieOverview.bottomAnchor , leading: contentView.leadingAnchor , trailing: contentView.trailingAnchor, paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 ,height: 220)

    }
}


extension MovieDetilasVC:FavoriteButtonDelegate {

    func shareSheetTaped() {

      present(sharSheet , animated: true)
    }
    
    func didtapedFavoriteButton() {
        guard let movieDetails else {return}
        
        do {
            let isInCoreData = try CoredataManager.shared.checkForMovie(with: movieDetails.id )
            if !isInCoreData {
                do {
                    guard let backdropImage else{return}
                    try CoredataManager.shared.save(withMovie: movieDetails, backdropImage: backdropImage )
                }catch {
                    if let error = error as? ErrorMassages {
                        presentAler(title: .defualtOne, message: error.rawValue)
                    }
                }
            }else {
                do {
                    try CoredataManager.shared.deleteMovie(withID: movieDetails.id)
                }catch {
                    if let error = error as? ErrorMassages {
                        presentAler(title: .defualtOne, message: error.rawValue)
                    }
                }
        }
            configuerButton(with: movieDetails.id)

        }catch {
            if let error = error as? ErrorMassages {
                presentAler(title: .defualtOne, message: error.rawValue)
            }        }
        
    }
}


extension MovieDetilasVC:playTrailerDelegte {
    func didTappedPlayButton(movieID: Int) {
        Task {
            showLoadingView()
            do{
                guard let youtubeLink = try await NetworkManager.shared.getMovieTrailerURL(movieID: movieID) else {return }
                pressenSafrieVC(with: youtubeLink)

            }catch {
                if let error = error as? ErrorMassages {
                    presentAler(title: .defualtOne , message: error.rawValue)
                }
            }
            dismissLoadingView()
        }
    
    }
    }
    
    


