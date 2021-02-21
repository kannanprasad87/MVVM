//
//  CurrentWeatherList.swift
//  MVVM
//
//  Created by Prasad, Kannan (UST) on 18/02/2021.
//

import Foundation

struct CurrentWeatherList: Codable,Hashable {
    let cnt: Int
    let list: [CurrentWeather]?
}
