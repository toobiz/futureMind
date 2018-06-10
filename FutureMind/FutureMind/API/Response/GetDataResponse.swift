//
//  GetDataResponse.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import ObjectMapper

class GetDataResponse: ImmutableMappable {
    
    let itemsList: [Item]?
    
    required init(map: Map) throws {
        itemsList = try? map.value("data")
    }
}

class Item: ImmutableMappable {
    
    let title: String?
    let description: String?
    let orderId: Int?
    let modificationDate: String?
    let imageUrl: String?
    
    required init(map: Map) throws {
        title = try? map.value("title")
        description = try? map.value("description")
        orderId = try? map.value("orderId")
        modificationDate = try? map.value("modificationDate")
        imageUrl = try? map.value("image_url")
    }
}
