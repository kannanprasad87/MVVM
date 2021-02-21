//
//  WeatherService.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

final class WeatherService:WeatherServiceProtocol {

    let networkManager:NetworkManager = NetworkManager(client: NetworkClient())
    var baseUrlString: String {
        return  Networking.Domain.Production
    }

    func getWeatherForCity(city:String, completion:@escaping((Result<CurrentWeather,NetworkError>) -> Void)) {

        let serviceString = "\(baseUrlString)/\(Networking.Domain.Path.Weather)"
        let queryParameters = ["q":city,
                               "appid":"5e0b2186e349e523ca488fdc5253c640",
                               "units":"metric"]
        guard let urlRequest = HttpRequestHandler().createRequest(serviceString,parameters:queryParameters, headers: [:]) else { return }

        networkManager.fetch(with: urlRequest, decodingType: CurrentWeather.self) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func getWeatherForCities(cityList:[String]?, completion:@escaping((Result<CurrentWeatherList,NetworkError>) -> Void)) {
        let webServiceUrlString = "\(baseUrlString)/\(Networking.Domain.Path.Group)"
        guard let cityList = cityList else { return }
        let idString = cityList.joined(separator:",")
        let customQueryParameters = ["id":idString,
                                     "appid":"5e0b2186e349e523ca488fdc5253c640",
                                     "units":"metric"]
        guard let urlRequest = HttpRequestHandler().createRequest(webServiceUrlString,parameters:customQueryParameters, headers: [:]) else { return }

        networkManager.fetch(with: urlRequest, decodingType: CurrentWeatherList.self) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
