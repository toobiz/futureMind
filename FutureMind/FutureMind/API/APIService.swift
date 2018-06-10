//
//  APIService.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Alamofire

protocol APIService {
    
    func getData(completion: ((DataResponse<GetDataResponse>) -> Void)) -> DataRequest
}

extension APISessionManager: APIService {
    
    func getData(completion: ((DataResponse<GetDataResponse>) -> Void)) -> DataRequest {
        return request(baseUrl, method: .get, encoding: JSONEncoding.default)
    }
    
    
}
