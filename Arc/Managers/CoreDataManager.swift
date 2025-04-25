//
//  CoreDataManager.swift
//  Arc
//
//  Created by Ahmed El Gndy on 25/04/2025.
//

import UIKit
import CoreData


class CoredataManager{
    static let shared = CoredataManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not get appDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func save(with Favoritemovie : Movie ) {
        
        let movie = FavoriteMovie(context: context)
        movie.title = Favoritemovie.title
        movie.id = Int32(Favoritemovie.id)
        
        do {
            try context.save()
            print("saved successfully")
        }catch {
            print("save error : ", error)
        }
    }
    
    func getAllMovies()-> [Movie] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        do {
            let movies = try context.fetch(fetchRequest) as? [FavoriteMovie] ?? []
            let movie = Movie.convertNSManagedObjectToMovie(favoriteMovies: movies)
            
            return movie
        }catch{
            return []
        }
        
    }
    
    //Check is the movie in CoreData or Note
    func checkForMovie(with id: Int ) -> Bool?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        print(id)
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
            return nil
        }
        
    }
    
    
    func deleteData(MovieTitle : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format:"title == %@" , MovieTitle)
        fetchRequest.predicate = predicate
        
        do {
            let movies =  try context.fetch(fetchRequest)
            
            for movie in movies {
                context.delete(movie)
            }
            try context.save()
        }catch {
            
        }
        
    }
}
