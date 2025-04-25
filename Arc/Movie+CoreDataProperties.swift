//
//  Movie+CoreDataProperties.swift
//  Arc
//
//  Created by Ahmed El Gndy on 25/04/2025.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var title: String?   
    @NSManaged public var id: Int32
}

extension FavoriteMovie : Identifiable {

}
