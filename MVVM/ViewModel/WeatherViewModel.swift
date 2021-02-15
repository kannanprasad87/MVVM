//
//  WeatherViewModel.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

protocol WeatherViewModelProtocol {
    func updateView()
    func failedToFetchWeather(error:String)
}

class WeatherViewModel {
    let service:WeatherService = WeatherService()
    var weather:[WeatherResponse] = [WeatherResponse]()

    private var view:WeatherViewModelProtocol?

    func attachView(view:WeatherViewModelProtocol){
        self.view = view
    }

    func detachView(){
        self.view = nil
    }

    func getWeatherForCity(city:String) {
        service.getWeatherForCity(city: city, completion: { result in
            switch(result){
            case .success(let weather):
                self.weather.append(weather)
                self.view?.updateView()
               break
            case .failure(let error):
                self.view?.failedToFetchWeather(error: error.localizedDescription)
                break
            }
        })
    }
}
