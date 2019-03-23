//
//  TranslationServiceTestCase.swift
//  AnAmericanDreamTests
//
//  Created by Yves TANTER on 17/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import XCTest
@testable import AnAmericanDream

class TranslationServiceTestCase: XCTestCase {

    // Test if there is an error
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let textToTranslate = "C'est perdu"
        let translationLanguage = "en"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate, translationLanguage: translationLanguage) { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Test if there is no data
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let textToTranslate = "C'est perdu"
        let translationLanguage = "en"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate, translationLanguage: translationLanguage) { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Test if the response is incorrect
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
        let textToTranslate = "C'est perdu"
        let translationLanguage = "en"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate, translationLanguage: translationLanguage) { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Test if the data is incorrect
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let textToTranslate = "C'est perdu"
        let translationLanguage = "en"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: textToTranslate, translationLanguage: translationLanguage) { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Test if there is no error and correct data
    func testGetTranslationShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        let textToTranslate = "C'est perdu"
        let translationLanguage = "en"
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation(textToTranslate: textToTranslate, translationLanguage: translationLanguage) { (success, translation) in
            let translatedText = "It's lost"
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            XCTAssertEqual(translatedText, translation?.data.translations[0].translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
}
