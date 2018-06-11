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
    let link: String?
    let orderId: Int?
    let modificationDate: String?
    let imageUrl: String?
    var image: UIImage?
    
    required init(map: Map) throws {
        title = try? map.value("title")
        description = try? map.value("description", using: ImmutableMappableTransformation.removeUrl())
        link = try? map.value("description", using: ImmutableMappableTransformation.extractUrl())
        orderId = try? map.value("orderId")
        modificationDate = try? map.value("modificationDate")
        imageUrl = try? map.value("image_url")
        image = try? map.value("image")
    }
    
    struct ImmutableMappableTransformation {
        
        static func removeUrl() -> TransformOf<String, Any> {
            return TransformOf<String, Any>(fromJSON: { (value: Any?) -> String? in
                if let value = value as? String {
                    var string = String()
                    if let index = value.range(of: "http")?.lowerBound {
                        let substring = value[..<index]
                        string = String(substring).condenseWhitespace()
                    }
                    return string
                }
                return nil
            }, toJSON: { (value: String?) -> String? in
                if let value = value {
                    return value
                }
                return nil
            })
        }
        
        static func extractUrl() -> TransformOf<String, Any> {
            return TransformOf<String, Any>(fromJSON: { (value: Any?) -> String? in
                if let value = value as? String {
                    var string = String()
                    if let index = value.range(of: "http")?.lowerBound {
                        let substring = value[index..<value.endIndex]
                        string = String(substring)
                        print(string)
                    }
                    return string
                }
                return nil
            }, toJSON: { (value: String?) -> String? in
                if let value = value {
                    return value
                }
                return nil
            })
        }
    }
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
