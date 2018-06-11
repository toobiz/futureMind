//
//  MainViewModel.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift
//import CoreData

class MainViewModel {
    
    var repository: APIRepositoryInterface
    let disposeBag = DisposeBag()
    var items: [Item]?
    let loadingSuccess = PublishSubject<Bool>()
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
//    lazy var context: NSManagedObjectContext =  {
//        return CoreDataStackManager.sharedInstance().managedObjectContext
//    }()
    
    func getData() {
        repository.getData().subscribe(onNext: { [unowned self] response in
            
//            for item in response.itemsList! {
//                let itemToAdd = Item(context: self.context)
//                CoreDataStackManager.sharedInstance().saveContext()
//            }
            
//            let imageSetToAdd = ImageSet(dictionary: imageDict, context: self.sharedContext)
//            CoreDataStackManager.sharedInstance().saveContext()
//            self.imageSets.append(imageSetToAdd)
            
            self.items = response.itemsList
            self.loadingSuccess.onNext(true)

//            var count = Int()
//            for item in response.itemsList! {
//                    self.repository.getImage(imageUrl: item.imageUrl!).subscribe(onNext: { image in
//                        item.image = image
//                        count += 1
//                        if count == response.itemsList?.count {
//                            self.items = response.itemsList
//                            self.loadingSuccess.onNext(true)
//                        }
//                    }, onError: { error in
//
//                    }).disposed(by: self.disposeBag)
//            }
            }, onError: { [unowned self] error in
                
        }).disposed(by: disposeBag)
    }
}
