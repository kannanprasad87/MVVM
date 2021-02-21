//
//  WeatherCellContentConfiguration.swift
//  MVVM
//
//  Created by Kannan, Prasad on 14/02/2021.
//

import UIKit

struct WeatherCellContentConfiguration: UIContentConfiguration, Hashable {

    var weather: CurrentWeather?

    func makeContentView() -> UIView & UIContentView {
        return WeatherCellContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> WeatherCellContentConfiguration {
        return self
    }
}
