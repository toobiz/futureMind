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
    
    let loadingSuccess = PublishSubject<UIImage?>()
    var repository: APIRepositoryInterface!
    let disposeBag = DisposeBag()
    var item: Item?
    var image: UIImage?
    
    init(withItem item: Item) {
        self.item = item
    }
    
    func setImage() {
        if item?.orderId == nil {
            self.loadingSuccess.onNext(nil)
            print("Image not available")
        } else if item?.image != nil {
            loadingSuccess.onNext(item?.image)
            print("Image retrieved from cache")
        } else {
            self.loadingSuccess.onNext(UIImage(named: "placeholder"))
            repository.getImage(imageUrl: (item?.imageUrl)!).subscribe(onNext: { image in
                self.image = image
                self.loadingSuccess.onNext(image)
            }, onError: { [unowned self] error in
                self.loadingSuccess.onNext(UIImage(named: "placeholder"))
            }).disposed(by: disposeBag)

        }
    }
    
}
