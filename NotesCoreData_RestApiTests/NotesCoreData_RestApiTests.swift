//
//  NotesCoreData_RestApiTests.swift
//  NotesCoreData_RestApiTests
//
//  Created by iMaxiOS on 7/5/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import XCTest

class NotesCoreData_RestApiTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testAPIRequest() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: URL(string: Constant.baseURL + "notes"
            )!) { (data, response, error) in
                statusCode = (response as? HTTPURLResponse)?.statusCode
                responseError = error
                promise.fulfill()
        }
        
        dataTask.resume()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
