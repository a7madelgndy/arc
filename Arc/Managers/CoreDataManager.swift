//
//  CoreDataManager.swift
//  Arc
//
//  Created by Ahmed El Gndy on 25/04/2025.
//

import UIKit
import CoreData

enum Enities {
    static let FavoriteMovieEntity  = "FavoriteMovie"
    
}


class CoredataManager{
    static let shared = CoredataManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not get appDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func save(with Favoritemovie : Movie ) throws{
        let movie = FavoriteMovie(context: context)
        
        movie.title = Favoritemovie.title
        movie.id = Int32(Favoritemovie.id)
        
        do {
            try context.save()
        }catch {
           throw ErrorMassages.unabletoSaveMovie
        }
    }
    
    func getAllMovies() throws->[Movie]  {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Enities.FavoriteMovieEntity)
        do {
            let movies = try context.fetch(fetchRequest) as? [FavoriteMovie] ?? []
            let movie = Movie.convertNSManagedObjectToMovie(favoriteMovies: movies)
            return movie
            
        }catch{
             throw ErrorMassages.unableToGetFavortiMovies
        }
    }
    
    //Check is the movie in CoreData or Note
    func checkForMovie(with id: Int ) throws -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Enities.FavoriteMovieEntity)
        
        let predicate = NSPredicate(format:"id == \(String(id))" )
        fetchRequest.predicate = predicate
        
        do {
            let movie =   try context.fetch(fetchRequest)
            if movie.isEmpty {
                return false
            }else {
                return true
            }
        }catch {
            throw ErrorMassages.unableToCheckForAMovie
        }
    }
    
    
    func deleteMovie(withID : Int)throws{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Enities.FavoriteMovieEntity)
        
        let predicate = NSPredicate(format:"id == \(String(Int32(withID)))" )
        fetchRequest.predicate = predicate
        
        do {
            let movies =  try context.fetch(fetchRequest)
            for movie in movies {
                context.delete(movie)
            }
            try context.save()

        }catch {
            throw ErrorMassages.unableToDeleteMovie
        }
    }
}
