//
//  ImmutableMappableTransformation.swift
//  FutureMind
//
//  Created by Michal Tubis on 12.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import ObjectMapper

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
