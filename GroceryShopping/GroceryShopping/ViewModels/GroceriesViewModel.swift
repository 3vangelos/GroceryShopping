//
//  GroceryViewModel.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

class GroceriesViewModel {
    
    var changeRates = ["USD": 1.0]
    var groceriesArray = [ Grocery(name: "Peas", cost: 0.95),
                           Grocery(name: "Eggs", cost: 2.10),
                           Grocery(name: "Milk", cost: 1.30),
                           Grocery(name: "Beans", cost: 0.73) ]
    
    init() {}

    func screenTitle() -> String {
        return "Grocery Shopping"
    }
    
    func totalCosts(_ currency: String) -> Float {
        let totalAmountInUSD = groceriesArray.reduce(0) { $0 + Float($1.amount) * $1.cost}
        let multiplier = changeRates[currency]
        return totalAmountInUSD  * Float(multiplier!)
    }
    
    func addToGroceryAtIndex(_ index: Int, amount: Int) {
        let newAmount = groceriesArray[index].amount + amount
        groceriesArray[index].amount = newAmount < 0 ? 0
                                    : newAmount > 99 ? 99
                                    : newAmount
    }
    
    func updateRates(errorAction: @escaping () -> () = {}, finishAction: @escaping () -> () = {}) {
        let task = ExchangeRateTask(baseCurrency: "USD")
        task.execute({ changeRates in
            self.changeRates = changeRates
            finishAction()
        }) { _ in
            errorAction()
        }
    }
}
