//
//  NetworkingManager.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

public enum HTTPMethod: String {
    case get = "GET"
}

public enum Parameters {
    case url(_ : [String: Any]?)
}

public enum DataType {
    case JSON
}

public protocol Request {
    var endpoint : String { get }
    var httpMethod : HTTPMethod { get }
    var parameters : Parameters { get }
    var dataType : DataType { get }
}




