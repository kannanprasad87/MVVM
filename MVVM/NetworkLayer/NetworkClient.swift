//
//  NetworkClient.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

final class NetworkClient:NetworkClientProtocol {

    private var session: URLSession = URLSession(configuration: .default)
    
    internal func fetch<T>(with request:URLRequest, decodingType: T.Type, completion:@escaping(Result<T, NetworkError>)-> Void) where T : Decodable {

        let fetchTask = session.dataTask(with: request) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(.failedRequestError))
                return
            }
            switch httpResponse.responseType {
            case .noError:
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(.success(genericModel))
                    }  catch DecodingError.keyNotFound(let key, let context) {
                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                        completion(.failure(.invalidDataError))
                    } catch DecodingError.valueNotFound(let type, let context) {
                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                        completion(.failure(.invalidDataError))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                        completion(.failure(.invalidDataError))
                    } catch DecodingError.dataCorrupted(let context) {
                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                        completion(.failure(.invalidDataError))
                    } catch let error as NSError {
                        NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                        completion(.failure(.invalidDataError))
                    }
                } else {
                    completion(.failure(.invalidDataError))
                }
            case .redirectionError,
                 .informationalError,
                 .clientError,
                 .serverError,
                 .undefinedError,
                 .failedRequestError,
                 .jsonConversionError,
                 .invalidDataError,
                 .unauthorisedResponseError,
                 .httpResponseError,
                 .jsonParsingError,
                 .invalidURLError:
                    completion(.failure(httpResponse.responseType))
            }
        }
        fetchTask.resume()
    }

}
