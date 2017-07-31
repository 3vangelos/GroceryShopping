//
//  Grocery.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos (415) on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

struct Grocery : Codable {
    let name : String
    var amount : Int = 0
    
    init(name: String) {
        self.name = name
    }
}
