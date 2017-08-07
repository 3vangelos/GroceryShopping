//
//  NetworkDispatcher.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case badInput
    case noData
}

public class NetworkDispatcher {
    
    private var session: URLSession

    required public init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func execute(request: Request, completion:@escaping(Response) -> ()) {
        let (urlRequest, networkError) = (self.prepare(request: request) as (URLRequest?, NetworkError?))
        if let urlRequest = urlRequest {
            let dataTask = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                let response = Response( (data, response as? HTTPURLResponse,error), for: request)
                completion(response)
            })
            dataTask.resume()
        } else {
            completion(Response((nil, nil, networkError), for: request))
        }
    }
    
    private func prepare(request: Request) -> (URLRequest?, NetworkError?) {
        let url = "\(request.endpoint)"
        var url_request = URLRequest(url: URL(string: url)!)

        switch request.parameters {
        case .url(let params):
            if let params = params as? [String: String] {
                let query_params = params.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                
                guard var components = URLComponents(string: url) else {
                    return (nil, NetworkError.badInput)
                }
                components.queryItems = query_params
                url_request.url = components.url
            } else {
                return (nil, NetworkError.badInput)
            }
        }

        url_request.httpMethod = request.httpMethod.rawValue
        return (url_request, nil)
    }
}
