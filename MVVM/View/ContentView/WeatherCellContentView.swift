//
//  WeatherCellContentView.swift
//  MVVM
//
//  Created by Kannan, Prasad on 14/02/2021.
//

import UIKit

class WeatherCellContentView: UIView, UIContentView {

    // We will work on the implementation in a short while.

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

        // 3
        // Load SFSymbolNameContentView.xib by making self as owner of SFSymbolNameContentView.xib
        Bundle.main.loadNibNamed("\(WeatherCellContentView.self)", owner: self, options: nil)

        // 4
        // Add SFSymbolNameContentView as subview and make it cover the entire content view
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        ])

        // 5
        // Add border & rounded corner to name label
//        nameLabel.layer.borderWidth = 1.5
//        nameLabel.layer.borderColor = UIColor.systemPink.cgColor
//        nameLabel.layer.cornerRadius = 5.0
    }

    private func apply(configuration: WeatherCellContentConfiguration) {

        // Only apply configuration if new configuration and current configuration are not the same
        guard currentConfiguration != configuration else {
            return
        }

        // Replace current configuration with new configuration
        currentConfiguration = configuration

        // Set name to label
        cityName?.text = configuration.weather?.locationName
        mainTemperature?.text = configuration.weather?.currentTemperature
        weatherDescription?.text = configuration.weather?.weatherDescription
        feelsLikeTemperature?.text = configuration.weather?.feelsLikeTemperature
        weatherIcon?.image = configuration.weather?.weatherIcon
        
    }
}
