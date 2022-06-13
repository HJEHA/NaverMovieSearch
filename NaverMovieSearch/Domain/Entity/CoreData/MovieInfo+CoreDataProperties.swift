//
//  MovieInfo+CoreDataProperties.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//
//

import Foundation
import CoreData


extension MovieInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInfo> {
        return NSFetchRequest<MovieInfo>(entityName: "MovieInfo")
    }
    
    @nonobjc public class func fetchRequest(title: String) -> NSFetchRequest<MovieInfo> {
        let request = fetchRequest()
        let symbolPredicate = NSPredicate(format: "title == %@", title)
        
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [symbolPredicate]
        )
        
        return request
    }

    @NSManaged public var actors: String
    @NSManaged public var director: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var pageLink: String
    @NSManaged public var posterURL: String
    @NSManaged public var title: String
    @NSManaged public var userRating: String

}

extension MovieInfo : Identifiable {

}
