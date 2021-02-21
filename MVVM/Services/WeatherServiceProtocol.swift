//
//  WeatherServiceProtocol.swift
//  MVVM
//
//  Created by Prasad, Kannan (UST) on 18/02/2021.
//

import Foundation

protocol WeatherServiceProtocol {

    var baseUrlString:String { get }

    func getWeatherForCity(city:String, completion:@escaping((Result<CurrentWeather,NetworkError>) -> Void))
    func getWeatherForCities(cityList:[String]?, completion:@escaping((Result<CurrentWeatherList,NetworkError>) -> Void))
}
