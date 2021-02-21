//
//  WeatherViewModel.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
import UIKit
import CoreData

protocol WeatherViewModelProtocol {
    func updateView()
    func failedToFetchWeather(error:String)
}

class WeatherViewModel {
    let service:WeatherService = WeatherService()
    var weather:[CurrentWeather] = [CurrentWeather]()

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

                //Persist City Details
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
                let savedLocation = Location.init(context: appDelegate.persistentContainer.viewContext)
                savedLocation.locationId = Int64(weather.id ?? 0)
                savedLocation.locationName = weather.name
                appDelegate.saveContext()
                self.view?.updateView()
               break
            case .failure(let error):
                self.view?.failedToFetchWeather(error: error.localizedDescription)
                break
            }
        })
    }

    func getWeatherForSavedLocations(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let request:NSFetchRequest<Location> = Location.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        do {
            let savedLocations = try context.fetch(request)
            if savedLocations.count > 0{
                var locationIds = [String]()
                for location in savedLocations {
                    locationIds.append(String(location.locationId))
                }

                service.getWeatherForCities(cityList: locationIds) { result in
                    switch (result){
                    case .success(let weatherList):
                        guard let weatherList = weatherList.list else { return }
                        for weather in weatherList {
                            self.weather.append(weather)
                        }
                        self.view?.updateView()
                    case .failure(let error):
                        self.view?.failedToFetchWeather(error: error.localizedDescription)
                    }
                }
            }
        } catch {
            print("Unexpected exception while fetching data : \(error)")
        }
    }
}
