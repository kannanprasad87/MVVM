//
//  WeatherServiceTests.swift
//  MVVMTests
//
//  Created by Kannan Prasad on 24/01/2021.
//

import XCTest

@testable import MVVM


class WeatherServiceTests: XCTestCase {

    var service: WeatherService?

    override func setUp() {
        super.setUp()
        self.service = WeatherService()
    }

    func testFetchWeatherData() {
        let promise = expectation(description: #function)
        service!.getWeatherForCity(city:"Bradford",completion: { result in
            XCTAssertTrue(Thread.isMainThread)
            switch result {
            case .success(let weather):
                XCTAssertNotNil(weather)
                XCTAssertTrue(weather.name! == "Bradford","Incorrect city details fetched")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 10.0)
    }

}
