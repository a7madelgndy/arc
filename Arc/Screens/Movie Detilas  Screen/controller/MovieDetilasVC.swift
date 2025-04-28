//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetilasVC: DataLoadingVC {
    var posterView = BoosterView()
    var headerView = MovieHeaderView()
    var categroiesView = MovieCategoriesView()
    var playTailerView = TrailerPlayerView()
    var movieOverview = BodyLabel()
    var movieCastView = MovieCastView()
    
    var castMembers:[CastMember]?
    
    var movie:Movie? {
        didSet {
            assignDataToViews()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstrains()
        configuerButton()
    }
    
    func set(with movie: Movie){
        self.movie = movie
    }

    private func getCastMemberData(with movieID : Int) {
        Task{
            #warning("please make the activty indicator in the image itself ")
            showLoadingView()
            do {
                
                castMembers = try await NetworkManager.shared.getMovieCast(movieId: String(movieID))
                
                
            }catch {
                presentDefaultError()
            }
            movieCastView.actors = self.castMembers
            dismissLoadingView()
        }
    }
    

    private func configuerButton() {
        guard let movie ,  let isMovieINcoreData = checkIsMovieIncordate(movieId: movie.id)  else {return}
        
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
        view.addSubViews(posterView, headerView, playTailerView, movieOverview, movieCastView,categroiesView)

        posterView.setConstrains(top: view.topAnchor , leading: view.leadingAnchor, trailing:  view.trailingAnchor , height: 300)
        
        headerView.setConstrains(top: posterView.bottomAnchor , leading:  view.leadingAnchor , trailing: view.trailingAnchor ,paddingTop: 10, height: 50)
        
        
        categroiesView.setConstrains(top:headerView.bottomAnchor , leading: view.leadingAnchor,trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20,paddingRight: 20 , height: 40)
        
        playTailerView.setConstrains(top:categroiesView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 , height: 40)
        playTailerView.delegate = self
        playTailerView.set(movieID: movie?.id ?? 0)
        
        movieOverview.setConstrains(top: playTailerView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop:  10 , paddingLeft:  20 , paddingRight: 20 , height: 100)
        
        
        movieCastView.setConstrains(top: movieOverview.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor, paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 ,height: 60)
    }
    
    
    private func assignDataToViews() {
        guard let movie else {return}
        
        if movie.poster_path != " " {
            posterView.cellData = movie.poster_path
        }
        
        headerView.setheaderVeiw(with: movie)
        headerView.delegage = self
        
        categroiesView = MovieCategoriesView(rating: movie.vote_average,
                                             language: movie.original_language,
                                             releadeData: movie.release_date,
                                             isAdult: movie.adult)

        getCastMemberData(with: movie.id)
        
        movieOverview.text = movie.overview
    }
    
}


extension MovieDetilasVC:FavoriteButtonDelegate {
    func didtapedFavoriteButton(for movie: Movie?) {
        guard let movie else {return}
        
        do {
            let isInCoreData = try CoredataManager.shared.checkForMovie(with: movie.id )
            if !isInCoreData {
                do {
                    guard let image = posterView.movieBooster.image else{return}
                    try CoredataManager.shared.save(withMovie: movie, posterImage: image )
                }catch {
                    if let error = error as? ErrorMassages {
                        presentAler(title: .defualtOne, message: error.rawValue)
                    }
                }
            }else {
                do {
                    try CoredataManager.shared.deleteMovie(withID: movie.id)
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
        
        
        configuerButton()
    }
}


extension MovieDetilasVC:playTrailerDelegte {
    func didTappedPlayButton(movieID: Int) {
        print("in the delegate")
        Task {
            do{
                
                guard let youtubeLink = try await NetworkManager.shared.getMovieTrailerURL(movieID: movieID) else {return }
                print(youtubeLink)
                print("here")
                pressenSafrieVC(with: youtubeLink)

            }catch {
                print("error")
            }
        }
    
   
        
    }
    }
    
    


