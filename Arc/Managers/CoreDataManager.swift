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
    
    
    func save(movieTitle : String ) {
        
        let movie = FavoriteMovie(context: context)
        movie.title = movieTitle
        
        do {
            try context.save()
            print("saved successfully")
        }catch {
            print("save error : ", error)
        }
    }
    
    
    func getMovies(title:String? = nil)-> [NSManagedObject]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format:"title == \(String(describing: title))")
        fetchRequest.predicate = predicate
        do {
  
            return  try context.fetch(fetchRequest)
            
        }catch {
            print(error)
            
            return []
        }
    }
    
    
    func deleteData(MovieTitle : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format:"title == \(MovieTitle)")
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
