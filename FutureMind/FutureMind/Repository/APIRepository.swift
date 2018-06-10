//
//  APIRepository.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift

class APIRepository: APIRepositoryInterface {
    
    private let service: APIService
    
    public init(service: APIService) {
        self.service = service
    }
    
    func getData() -> Observable<GetDataResponse> {
        return Observable.create { [weak self] observer in
            guard let `self` = self else {
                observer.onCompleted()
                return  Disposables.create()
            }
            
            self.service.getData() { response in
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func getImage(imageUrl: String) -> Observable<UIImage> {
        return Observable.create { [weak self] observer in
            guard let `self` = self else {
                observer.onCompleted()
                return  Disposables.create()
            }
            
            self.service.getImage(imageUrl) { response in
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
