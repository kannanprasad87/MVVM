//
//  WeatherViewController.swift
//  Wind
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
struct Wind : Codable,Hashable {
	let speed : Double?
	let deg : Int?
    let uuid: String?

    static func == (lhs: Wind, rhs: Wind) -> Bool {
        return lhs.uuid == rhs.uuid
    }

	enum CodingKeys: String, CodingKey {

		case speed = "speed"
		case deg = "deg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		speed = try values.decodeIfPresent(Double.self, forKey: .speed)
		deg = try values.decodeIfPresent(Int.self, forKey: .deg)
        uuid = UUID().uuidString
	}

}
