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
    var items = [Item]()
    let loadingSuccess = PublishSubject<Bool>()
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() {
        repository.getData().subscribe(onNext: { [unowned self] response in
            guard let data = response.itemsList else { return }
            self.items = data
            self.loadingSuccess.onNext(true)
            }, onError: { [unowned self] error in
                
        }).disposed(by: disposeBag)
    }
}
