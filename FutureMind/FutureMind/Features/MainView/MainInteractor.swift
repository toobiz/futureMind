//
//  MainInteractor.swift
//  FutureMind
//
//  Created by Michal Tubis on 16.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift

class MainInteractor {
    
    let repository: APIRepositoryInterface!
    
    required init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() -> Observable<GetDataResponse> {
        return self.repository.getData()
    }
    
    func getImage(imageUrl: String) -> Observable<UIImage> {
        return self.repository.getImage(imageUrl: imageUrl)
    }
}
