//
//  WeatherService.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

class WeatherService {

    let networkManager:NetworkManager = NetworkManager(client: NetworkClient())

    func getWeatherForCity(city:String, completion:@escaping((Result<WeatherResponse,NetworkError>) -> Void)) {
        let baseUrl = Networking.Domain.Production
        let serviceString = "\(baseUrl)/\(Networking.Domain.Path.Weather)"

        let queryParameters = ["q":city,
                               "appid":"5e0b2186e349e523ca488fdc5253c640",
                               "units":"metric"]
        guard let urlRequest = HttpRequestHandler().createRequest(serviceString,parameters:queryParameters, headers: [:]) else { return }

        networkManager.fetch(with: urlRequest, decodingType: WeatherResponse.self) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
    }
}
