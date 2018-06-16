//
//  MainViewModel.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class MainViewModel {
    
    var repository: APIRepositoryInterface
    let disposeBag = DisposeBag()
    var items = [Item]()
    let isLoading = Variable<Bool>(false)
    let loadingSuccess = PublishSubject<Bool>()
    let webViewIdentifier = "WebViewController"
    
    lazy var sharedContext: NSManagedObjectContext =  {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    init(repository: APIRepositoryInterface) {
        self.repository = repository
    }
    
    func getData() {
        items = getSavedData()
        items.sort(by: {Int(truncating: $0.orderId!) < Int(truncating: $1.orderId!) })
        
        if items.count == 0 {
            isLoading.value = true
            repository.getData().subscribe(onNext: { [unowned self] response in
                guard let data = response.itemsList else { return }
                self.items = data
                self.items.sort(by: {Int(truncating: $0.orderId!) < Int(truncating: $1.orderId!) })
                self.isLoading.value = false
                self.loadingSuccess.onNext(true)
                }, onError: { [unowned self] error in
                    self.isLoading.value = false
            }).disposed(by: disposeBag)
        }
    }
    
    func refreshData() {
        repository.getData().subscribe(onNext: { [unowned self] response in
            guard let data = response.itemsList else { return }
            self.clearSavedData()
            self.items = data
            self.items.sort(by: {Int(truncating: $0.orderId!) < Int(truncating: $1.orderId!) })
            self.loadingSuccess.onNext(true)
        }).disposed(by: disposeBag)
    }
    
    func getSavedData() -> [Item] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            return try sharedContext.fetch(fetchRequest) as! [Item]
        } catch let error as NSError {
            print(error)
            return [Item]()
        }
    }
    
    func clearSavedData() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try sharedContext.execute(deleteRequest)
            try sharedContext.save()
        } catch let error as NSError {
            print (error)
        }
    }
}
