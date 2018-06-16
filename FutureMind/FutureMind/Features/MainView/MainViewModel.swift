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
    let isLoading = Variable<Bool>(false)
    let loadingSuccess = PublishSubject<Bool>()
    let webViewIdentifier = "WebViewController"
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() {
        isLoading.value = true
        repository.getData().subscribe(onNext: { [unowned self] response in
            guard let data = response.itemsList else { return }
            self.items = data
            self.isLoading.value = false
            self.loadingSuccess.onNext(true)
            }, onError: { [unowned self] error in
                self.isLoading.value = false
        }).disposed(by: disposeBag)
    }
}
