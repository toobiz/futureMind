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
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() {
        repository.getData().subscribe(onNext: { [unowned self] response in
            print(response)
            }, onError: { [unowned self] error in
                
        }).disposed(by: disposeBag)
    }
}
