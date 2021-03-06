//
//  APIRepositoryInterface.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import RxSwift

protocol APIRepositoryInterface {
    func getData() -> Observable<GetDataResponse>
    func getImage(imageUrl: String) -> Observable<UIImage>
}
