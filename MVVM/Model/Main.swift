//
//  WeatherViewController.swift
//  Main
//
//  Created by Kannan Prasad on 24/01/2021.
//


import Foundation
struct Main : Codable,Hashable {

	let temp : Double?
	let feelsLike : Double?
	let tempMin : Double?
	let tempMax : Double?
	let pressure : Int?
	let seaLevel : Int?
	let grndLevel : Int?
	let humidity : Int?
    let uuid: String?


    static func == (lhs: Main, rhs: Main) -> Bool {
        return lhs.uuid == rhs.uuid
    }

	enum CodingKeys: String, CodingKey {

		case temp = "temp"
		case feelsLike = "feels_like"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure = "pressure"
		case seaLevel = "sea_level"
		case grndLevel = "grnd_level"
		case humidity = "humidity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp)
		feelsLike = try values.decodeIfPresent(Double.self, forKey: .feelsLike)
		tempMin = try values.decodeIfPresent(Double.self, forKey: .tempMin)
		tempMax = try values.decodeIfPresent(Double.self, forKey: .tempMax)
		pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
		seaLevel = try values.decodeIfPresent(Int.self, forKey: .seaLevel)
		grndLevel = try values.decodeIfPresent(Int.self, forKey: .grndLevel)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        uuid = UUID().uuidString
	}

}
