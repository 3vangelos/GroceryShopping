//
//  ExchangeRateTask.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

class ExchangeRateTask {
    
    let apiKey: String
    let baseCurrency: String
    
    init(baseCurrency: String) {

        self.apiKey = Bundle.main.infoDictionary!["CurrencyApiKey"] as! String
        self.baseCurrency = baseCurrency
    }
    
    var request: Request {
        return CurrencyRequest.exchangeRate(apiKey: self.apiKey, baseCurrency: baseCurrency)
    }
    
    func execute(_ completion: @escaping([String: Double]) -> (), error: @escaping(Error?) -> () = { _ in return }) {
        let dispatcher = NetworkDispatcher()
        dispatcher.execute(request: self.request) { response in
            switch response {
            case .error(let networkError):
                error(networkError)
            case .json(let dict):
                if let responseJSON = dict["quotes"] as? [String: Double] {
                    var changeRates : [String: Double] = [String: Double]()
                    for (currency, conversionRate) in responseJSON {
                        let currencyString = String(currency.dropFirst(3))
                        changeRates[currencyString] = conversionRate
                    }
                    completion(changeRates)
                } else {
                    error(NetworkError.noData)
                }
            }
        }
    }
}
