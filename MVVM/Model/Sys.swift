//
//  WeatherViewController.swift
//  Sys
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
struct Sys : Codable,Hashable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?

    static func == (lhs: Sys, rhs: Sys) -> Bool {
        return lhs.id == rhs.id
    }

	enum CodingKeys: String, CodingKey {
		case id = "id"
        case type = "type"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
	}

}
