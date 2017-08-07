//
//  CurrencyStore.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

public enum CurrencyRequest: Request {

    case exchangeRate(apiKey: String, baseCurrency: String)
    
    public var endpoint: String {
        switch self {
        case .exchangeRate(_,_):
            return "http://apilayer.net/api/live?"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .exchangeRate(_,_):
            return .get
        }
    }
    
    public var parameters: Parameters {
        switch self {
        case .exchangeRate(let apiKey, let baseCurrency):
            return .url(["access_key": apiKey, "source": baseCurrency])
        }
    }
        
    public var dataType: DataType {
        switch self {
        case .exchangeRate(_,_):
            return .JSON
        }
    }
}
