//
//  WeatherViewController.swift
//  Coord
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
struct Coord : Codable,Hashable {
	let lat : Double?
	let lon : Double?
    let uuid: String?

    static func == (lhs: Coord, rhs: Coord) -> Bool {
        return lhs.uuid == rhs.uuid
    }

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lon = "lon"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        uuid = UUID().uuidString
	}

}
