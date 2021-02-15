//
//  Constants.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

enum Constants {

    static let apiKey = "5e0b2186e349e523ca488fdc5253c640"

}

struct Networking {
    struct Domain {
        static let Production = "https://api.openweathermap.org/data/2.5/"

        struct Path {
            static let Weather = "weather"
        }
    }
}
