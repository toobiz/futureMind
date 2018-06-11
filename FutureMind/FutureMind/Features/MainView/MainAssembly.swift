//
//  MainAssembly.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(MainViewController.self) { r, c in
                c.viewModel = r.resolve(MainViewModel.self)
        }
        
        container.register(MainViewModel.self) { r in
            return MainViewModel(repository: r.resolve(APIRepositoryInterface.self)!)
        }
        
        container.register(APIRepositoryInterface.self) { r in
            return APIRepository(service: r.resolve(APIService.self)!)
        }
        
        container.register(APIService.self) { r in
            return r.resolve(APISessionManager.self)!
        }
    }
}
