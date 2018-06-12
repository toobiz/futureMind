//
//  PrototypeCellViewModel.swift
//  FutureMind
//
//  Created by Michal Tubis on 12.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift

class PrototypeCellViewModel {
    
    let loadingSuccess = PublishSubject<Bool>()
    var repository: APIRepositoryInterface!
    let disposeBag = DisposeBag()
    var item: Item?
    var image: UIImage?
    
    init(withItem item: Item) {
        self.item = item
    }
    
    func getImage() {
        repository.getImage(imageUrl: (item?.imageUrl)!).subscribe(onNext: { image in
            self.image = image
            self.loadingSuccess.onNext(true)
        }, onError: { [unowned self] error in
            
        }).disposed(by: disposeBag)
    }
    
}
