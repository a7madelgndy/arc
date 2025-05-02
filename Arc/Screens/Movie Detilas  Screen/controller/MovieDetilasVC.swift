//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetilasVC: DataLoadingVC {
    //backdrop_path
    var backdropView = BackdropView()
    var headerView = MovieHeaderView()
    var categroiesView = MovieCategoriesView()
    var playTailerView = TrailerPlayerView()
    var movieOverview = BodyLabel()
    var movieCastView = MovieCastView()
    
    var castMembers:[CastMember]?
    
    var backdropImage:UIImage?
  
    var movieDetails : MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstrains()
        guard let movieDetails else {return}
        getBackdropImage(with: movieDetails.backdrop_path!)
        assignDataToViews()
        getCastMemberData(with: movieDetails.id)
        //configuerButton()
    }
    
    
    private func getBackdropImage(with path: String)  {
        Task {
            backdropImage = await NetworkManager.shared.downloadImage(from: path)
            guard let backdropImage else {return}
            backdropView.BackdropImageView.image = backdropImage
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
    
    func setWithFavoriteMovie(favoriteMovie: FavoriteMovieModel ){
        backdropView.BackdropImageView.image = favoriteMovie.backdropImage        
    }
    
    private func configuerButton() {
        guard let movieDetails ,  let isMovieINcoreData = checkIsMovieIncordate(movieId: movieDetails.id)  else {return}
        
        if isMovieINcoreData {
            headerView.favoriteButton.configuration?.image = UIImage(systemName: "heart.fill")
        }else {
            headerView.favoriteButton.configuration?.image = UIImage(systemName: "heart")
            
        }
    }
    
    
     private func checkIsMovieIncordate(movieId : Int)-> Bool? {
        do{
            let  isInCoreData = try CoredataManager.shared.checkForMovie(with: movieId )
            return isInCoreData
        }catch {
            presentAler(title: .defualtOne , message: error.localizedDescription )
        }
        
        return nil
    }
    
    
    private func configureConstrains() {
        view.addSubViews(backdropView, headerView, playTailerView, movieOverview, movieCastView,categroiesView)

        backdropView.setConstrains(top: view.topAnchor , leading: view.leadingAnchor, trailing:  view.trailingAnchor , height: UIScreen.main.bounds.width*1/2)
        
        headerView.setConstrains(top: backdropView.bottomAnchor , leading:  view.leadingAnchor , trailing: view.trailingAnchor ,paddingTop: 10, height: 50)
        
        
        categroiesView.setConstrains(top:headerView.bottomAnchor , leading: view.leadingAnchor,trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20,paddingRight: 20 , height: 40)
        
        playTailerView.setConstrains(top:categroiesView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 , height: 40)
        playTailerView.delegate = self
        playTailerView.set(movieID: movieDetails?.id ?? 0)
        
        movieOverview.setConstrains(top: playTailerView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop:  10 , paddingLeft:  20 , paddingRight: 20 , height: 100)
        
        
        movieCastView.setConstrains(top: movieOverview.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor, paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 ,height: 60)
    }
    
    
    private func assignDataToViews() {
        guard let movieDetails else {return}
        headerView.configureheaderVeiw(with: movieDetails)
        headerView.delegage = self
     
        categroiesView.configuer(rating: Float(movieDetails.vote_average), language: movieDetails.original_language, releadeData: movieDetails.release_date, isAdult: movieDetails.adult)
        
    
        //getCastMemberData(with: movieDetails.id)
        
        movieOverview.text = movieDetails.overview
    }
    
    let moviUrl = URL(string: "MovieUrl")
    lazy var sharSheet = UIActivityViewController(activityItems: [moviUrl!],applicationActivities:  nil)


    
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
                    try CoredataManager.shared.save(withMovie: movieDetails, posterImage: backdropImage )
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
    
    


