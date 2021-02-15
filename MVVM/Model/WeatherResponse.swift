//
//  WeatherViewController.swift
//  WeatherResponse
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
import UIKit

struct WeatherResponse : Codable,Hashable {

    let coord : Coord?
    let weather : [Weather]?
    let base : String?
    let main : Main?
    let visibility : Int?
    let wind : Wind?
    let clouds : Clouds?
    let dt : Int?
    let sys : Sys?
    let timezone : Int?
    let id : Int?
    let name : String?
    let cod : Int?
    let message: String?

    func hash(into hasher:inout Hasher){
        hasher.combine(id)
    }

    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.id ==  rhs.id
    }


    enum CodingKeys: String, CodingKey {

        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

    var locationName:String? {
        return "\(self.name ?? "" ), \(self.sys?.country ?? "")"
    }

    var currentTemperature: String? {
        return "\(self.main?.temp ?? 0)°C"
    }

    var weatherIcon:UIImage? {
        return UIImage(url: URL(string: "https://openweathermap.org/img/wn/\(self.weather?.first?.icon ?? "").png"))
    }

    var weatherDescription: String? {
        return "\(self.weather?.first?.description?.capitalized ?? "")"
    }

    var feelsLikeTemperature: String? {
        return "Feels Line \(self.main?.feelsLike ?? 0)°C"
    }
}
