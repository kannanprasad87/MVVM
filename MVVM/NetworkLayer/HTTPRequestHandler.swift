//
//  HTTPRequestHandler.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

struct HttpRequestHandler {

    enum httpMethod:String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    func createRequest(_ urlString:String?,method:httpMethod = .get,parameters:[String:String]? = [:],encoding:[String:String] = ["Content-type": "application/json"],headers:[String:String]) -> URLRequest? {

        guard let urlString = urlString else { return nil}
        guard var urlComponents = URLComponents.init(string: urlString) else { return nil}
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else { return nil}
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }
}


