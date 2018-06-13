//
//  GetDataResponse.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

class GetDataResponse: ImmutableMappable {
    
    let itemsList: [Item]?
    
    required init(map: Map) throws {
        itemsList = try? map.value("data")
    }
}

@objc (Item)
class Item: NSManagedObject, ImmutableMappable {
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var link: String?
    @NSManaged var orderId: NSNumber?
    @NSManaged var modificationDate: String?
    @NSManaged var imageUrl: String?
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required init(map: Map) throws {
        let context = CoreDataStackManager.sharedInstance().managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
        super.init(entity: entity!, insertInto: context)
        
        title = try? map.value("title")
        desc = try? map.value("description", using: ImmutableMappableTransformation.removeUrl())
        link = try? map.value("description", using: ImmutableMappableTransformation.extractUrl())
        orderId = try? map.value("orderId")
        modificationDate = try? map.value("modificationDate")
        imageUrl = try? map.value("image_url")

        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    var image: UIImage? {
        
        get {
            let fileName = desc
            return ImageCache.Caches.imageCache.imageWithIdentifier(fileName)
        }
        
        set {
            if desc != nil {
                let fileName = desc
                ImageCache.Caches.imageCache.storeImage(newValue, withIdentifier: fileName!)
            }
        }
    }
}
