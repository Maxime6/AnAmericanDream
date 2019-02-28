//
//  WeatherServiceTestCase.swift
//  AnAmericanDreamTests
//
//  Created by Yves TANTER on 17/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import XCTest
@testable import AnAmericanDream

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let city = "New York"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWheather(city: city) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let city = "New York"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWheather(city: city) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        let city = "New York"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWheather(city: city) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let city = "New York"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWheather(city: city) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let city = "New York"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWheather(city: city) { (success, weather) in
            let description = "light rain"
            let temperature = 0.67
            let humidity = 40
            let clouds = 1
            let windSpeed = 4.46
            let windDeg = 352
            
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(description, weather?.weather[0].description)
            XCTAssertEqual(temperature, weather?.main.temp)
            XCTAssertEqual(humidity, weather?.main.humidity)
            XCTAssertEqual(clouds, weather?.clouds.all)
            XCTAssertEqual(windSpeed, weather?.wind.speed)
            XCTAssertEqual(windDeg, weather?.wind.deg)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }

}
