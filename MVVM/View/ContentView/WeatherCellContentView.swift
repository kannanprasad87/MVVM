//
//  WeatherCellContentView.swift
//  MVVM
//
//  Created by Kannan, Prasad on 14/02/2021.
//

import UIKit

class WeatherCellContentView: UIView, UIContentView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var cityName: UILabel?
    @IBOutlet weak var mainTemperature:UILabel?
    @IBOutlet weak var feelsLikeTemperature:UILabel?
    @IBOutlet weak var weatherDescription:UILabel?
    @IBOutlet weak var weatherIcon:UIImageView?

    private var currentConfiguration:WeatherCellContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get {
             currentConfiguration
        }

        set {
            guard let newConfiguration = newValue as? WeatherCellContentConfiguration else { return }
            apply(configuration: newConfiguration)
        }
    }

    init(configuration: WeatherCellContentConfiguration) {
        super.init(frame: .zero)
        loadNib()
        apply(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherCellContentView {

    private func loadNib() {
        Bundle.main.loadNibNamed("\(WeatherCellContentView.self)", owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        ])
    }

    private func apply(configuration: WeatherCellContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }

        currentConfiguration = configuration

        cityName?.text = configuration.weather?.locationName
        mainTemperature?.text = configuration.weather?.currentTemperature
        weatherDescription?.text = configuration.weather?.weatherDescription
        feelsLikeTemperature?.text = configuration.weather?.feelsLikeTemperature
        weatherIcon?.image = configuration.weather?.weatherIcon
    }
}
