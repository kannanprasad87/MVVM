//
//  WeatherViewController.swift
//  Clouds
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation
struct Clouds : Codable,Hashable {
	let all : Int?
    let uuid: String?

    static func == (lhs: Clouds, rhs: Clouds) -> Bool {
        return lhs.uuid == rhs.uuid
    }
	enum CodingKeys: String, CodingKey {
		case all = "all"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		all = try values.decodeIfPresent(Int.self, forKey: .all)
        uuid = UUID().uuidString
	}

}
