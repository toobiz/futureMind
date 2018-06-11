//
//  String+Whitespaces.swift
//  FutureMind
//
//  Created by Michal Tubis on 12.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
