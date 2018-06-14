//
//  WebViewAssembly.swift
//  FutureMind
//
//  Created by Michal Tubis on 14.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class WebViewAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(WebViewController.self) { r, c in
            c.viewModel = r.resolve(WebViewModel.self)
        }
        
        container.register(WebViewModel.self) { r in
            return WebViewModel()
        }
    }
}
