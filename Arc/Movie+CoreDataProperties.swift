//
//  Movie+CoreDataProperties.swift
//  Arc
//
//  Created by Ahmed El Gndy on 25/04/2025.
//
//

import CoreData
import UIKit

extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var title: String?   
    @NSManaged public var id: Int32   
    @NSManaged public var adult: Bool
    @NSManaged public var originalLanguage: String
    @NSManaged public var overView: String
    @NSManaged public var posterImage: UIImage
    @NSManaged public var releaseData: String
    @NSManaged public var voteAverage: Float
}

extension FavoriteMovie : Identifiable {

}
