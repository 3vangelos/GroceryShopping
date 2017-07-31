//
//  GroceryViewModel.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos (415) on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

class GroceriesViewModel {
    
    var groceriesArray = [ Grocery(name: "Peas", cost: 0.95),
                           Grocery(name: "Eggs", cost: 2.10),
                           Grocery(name: "Milk", cost: 1.30),
                           Grocery(name: "Beans", cost: 0.73) ]
    
    var changeRates = ["USD": 1.0, "CAD": 0.0, "EUR": 0.0, "GBP": 0.0, "CHF": 0.0, "JPY": 0.0, "MYR": 0.0]
    
    init() {
    }
    
    func updateRates(errorAction: @escaping () -> () = {}) {
        
        // check if API Key exists, check that it has no whitespaces
        guard let apiKey = Bundle.main.infoDictionary!["CurrencyApiKey"] as? String, apiKey.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else {
            errorAction()
            return
        }
        
        let currencies = Array(changeRates.keys).reduce("", { $0 == "" ? $1 : $0 + "," + $1 })
        let url = URL(string: "http://apilayer.net/api/live?access_key=\(apiKey)0&currencies=\(currencies)&source=USD")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (responseData, response, error) -> Void in
            guard let responseData = responseData, error == nil else {
                errorAction()
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: responseData, options:[])
            if let responseJSON = responseJSON as? [String: Any], let data = responseJSON["quotes"] as? [String: Double] {
                for (currency, conversionRate) in data {
                    let currencyString = String(currency.dropFirst(3))
                    self.changeRates[currencyString] = conversionRate
                }
            }
            }.resume()
    }
}
