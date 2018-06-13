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
    var image = Variable<UIImage?>(nil)
    
    init(withItem item: Item) {
        self.item = item
    }
    
    func setImage() {
        image.value = #imageLiteral(resourceName: "placeholder")
        if item?.imageUrl == nil {
            image.value = nil
        }
        if item?.image != nil {
            image.value = (item?.image)!
        } else {
            repository.getImage(imageUrl: (item?.imageUrl)!).subscribe(onNext: { image in
                if self.item?.image == nil {
                    self.item?.image = image
                    self.image.value = image
                }
            }, onError: { [unowned self] error in
                if self.image.value != #imageLiteral(resourceName: "placeholder") {
                    self.image.value = #imageLiteral(resourceName: "placeholder")
                }
            }).disposed(by: disposeBag)
        }
    }
}
