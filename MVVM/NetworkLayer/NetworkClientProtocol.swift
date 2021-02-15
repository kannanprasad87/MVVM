//
//  NetworkClientProtocol.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

protocol NetworkClientProtocol {

    func fetch<T:Decodable>(with request:URLRequest, decodingType:T.Type, completion:@escaping (Result<T,NetworkError>) -> Void)
    
}
