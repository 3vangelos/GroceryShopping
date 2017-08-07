//
//  Alerts.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class Alerts {
    
    static func showTotalCosts(target: UIViewController, amount: Float, currency: String, action: @escaping () -> () = { return }) {
        let title = "Total costs"
        let cutAmount = String(format: "%.2f", amount)
        let description = "the groceries you selected will cost you \(cutAmount) \(currency)"
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { _ in
            action()
        })
        
        alertController.addAction(alertAction)
        target.present(alertController, animated: true)
    }
    
    static func showNetworkError(target: UIViewController) {
        let title = "Network Error"
        let description = "An Error occured. Please check your network connection and check if you have a valid API Key to use the currency converter!"
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(alertAction)
        target.present(alertController, animated: true)
    }
    
    static func succesfullUpdate(target: UIViewController) {
        let title = "Currencies Updated"
        let description = "The new conversion rates have been downloaded succesfully"
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(alertAction)
        target.present(alertController, animated: true)
    }
}
