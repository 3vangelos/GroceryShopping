//
//  NetworkResponse.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

public enum Response {
    case json(_: [String: Any])
    case error(_: Error?)
    
    init(_ responseData: (data: Data?, response: HTTPURLResponse?, error: Error?), for request: Request) {
        guard responseData.response?.statusCode == 200, responseData.error == nil else {
            self = .error(responseData.error)
            return
        }
        
        guard let data = responseData.data else {
            self = .error(NetworkError.noData)
            return
        }
        
        switch request.dataType {
        case .JSON:
            guard let json = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String: Any] else {
                self = .error(NetworkError.noData)
                return
            }
            self = .json(json)
        }
    }
}
