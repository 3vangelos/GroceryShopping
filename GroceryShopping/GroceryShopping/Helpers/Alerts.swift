//
//  Alerts.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos (415) on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class Alerts {
    
    static func showTotalCosts(target: UIViewController, amount: Float, action: @escaping () -> () = { return }) {
        let title = "Total costs"
        let description = "the groceries you selected will cost you \(amount) US Dollar"
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { _ in
            action()
        })
        
        alertController.addAction(alertAction)
        target.present(alertController, animated: true)
    }
}
