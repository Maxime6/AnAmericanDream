//
//  ExchangeRateServiceTestCase.swift
//  AnAmericanDreamTests
//
//  Created by Yves TANTER on 14/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import XCTest
@testable import AnAmericanDream

class ExchangeRateServiceTestCase: XCTestCase {

    func testGetExchangeRateShouldPostFailedCallbackIfError() {
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfNoData() {
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectResponse() {
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetExchangeRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            let usd = 1.129414
            
            XCTAssertTrue(success)
            XCTAssertNotNil(exchangeRate)
            XCTAssertEqual(usd, exchangeRate?.rates.usd)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }

}
