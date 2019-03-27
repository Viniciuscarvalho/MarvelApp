//
//  APIClientTests.swift
//  MarvelAppTests
//
//  Created by Vinicius Marques on 25/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import XCTest

@testable import MarvelApp

class T: Codable {
    let name: String
}

class APIClientTests: XCTestCase {
    
    let testMD5String = "CY9rzUYh03PK3k6DJie09g=="
    
    func testFunctionForMD5() {
        let client = APIClient<T>()
        XCTAssert(client.MD5(string: "test").base64EncodedString() == self.testMD5String)
    }
    
    func testAPIClientError() {
        let client = Endpoints(path: "@", params: [:])
        let exp = self.expectation(description: "ErrorOnLoad")
        APIClient<Serie>.get(client) { result in
            switch result {
            case .success(_):
                XCTAssert(false)
                return
            case .error(_):
                XCTAssert(true)
                exp.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
}
