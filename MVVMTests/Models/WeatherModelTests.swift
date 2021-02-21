//
//  WeatherModelTests.swift
//  MVVMTests
//
//  Created by Prasad, Kannan (UST) on 18/02/2021.
//

import XCTest
@testable import MVVM

class WeatherModelTests: XCTestCase {

    var currentWeather:CurrentWeather?

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func setUp() {
        parseMockResponse()
    }

    func parseMockResponse() {
        if let path = Bundle(for:type(of: self)).path(forResource: "SingleLocationResponse", ofType:"json"){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
                let decoder = JSONDecoder()
                currentWeather = try? decoder.decode(CurrentWeather.self, from: data)
            } else {
                XCTFail("Exception")
            }
        }
    }

    func testCurrentWeatherModel() throws {
        XCTAssertEqual(currentWeather?.currentTemperature,"2.22°C")
        XCTAssertEqual(currentWeather?.locationName,"Bradford, GB")
        XCTAssertEqual(currentWeather?.weatherDescription,"Overcast Clouds")
        XCTAssertEqual(currentWeather?.feelsLikeTemperature,"Feels Like -2.8°C")
    }

}
