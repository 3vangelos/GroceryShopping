//
//  Grocery.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

struct Grocery : Codable {
    let name : String
    let cost : Float
    var amount : Int = 0
    
    
    init(name: String, cost: Float) {
        self.name = name
        self.cost = cost
    }
}
