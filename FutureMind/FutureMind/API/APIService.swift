//
//  APIService.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Alamofire
import AlamofireImage
import AlamofireObjectMapper

protocol APIService {
    
    @discardableResult func getData( completion: @escaping ((DataResponse<GetDataResponse>) -> Void)) -> DataRequest
    @discardableResult func getImage(_ imageUrl: String, completion: @escaping ((DataResponse<UIImage>) -> Void)) -> DataRequest
}

extension APISessionManager: APIService {
    
    @discardableResult func getData( completion: @escaping ((DataResponse<GetDataResponse>) -> Void)) -> DataRequest {
        return request(baseUrl, method: .get, encoding: JSONEncoding.default).responseObject(completionHandler: completion)
    }
    
    @discardableResult func getImage(_ imageUrl: String, completion: @escaping ((DataResponse<UIImage>) -> Void)) -> DataRequest {
        return request(imageUrl, method: .get, encoding: JSONEncoding.default).responseImage(completionHandler: completion)
    }
    
}
