//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Ahad Islam on 5/6/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String
    @NSManaged public var director: String
    @NSManaged public var year: Int16

}
