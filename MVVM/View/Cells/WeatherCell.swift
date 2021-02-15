//
//  CityWeatherCell.swift
//  MVVM
//
//  Created by Kannan Prasad on 13/02/2021.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    var currentWeather: WeatherResponse?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
        // Create new configuration object and update it base on state
        var newConfiguration = WeatherCellContentConfiguration().updated(for: state)
        
        // Update any configuration parameters related to data item
        newConfiguration.weather = currentWeather
        
        // Set content configuration in order to update custom content view
        contentConfiguration = newConfiguration
        
    }
    
    
}
