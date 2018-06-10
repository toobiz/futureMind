//
//  MainViewModel.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    
    var repository: APIRepositoryInterface
    let disposeBag = DisposeBag()
    var items: [Item]?
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() {
        repository.getData().subscribe(onNext: { [unowned self] response in
            for item in response.itemsList! {
                    self.repository.getImage(imageUrl: item.imageUrl!).subscribe(onNext: { image in
                        item.image = image
                        self.items = response.itemsList
                    }, onError: { error in
                        
                    }).disposed(by: self.disposeBag)
            }
            }, onError: { [unowned self] error in
                
        }).disposed(by: disposeBag)
    }
}
