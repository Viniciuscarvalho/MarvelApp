//
//  ModelsStub.swift
//  MarvelAppTests
//
//  Created by Vinicius Marques on 25/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ModelsStub: XCTestCase {
    
    func testModelForComic() {
        if let data = loadDataFromFile(name: "comic") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject2.description = "Test-modelComic"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "Test-modelComic")
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testModelForSerie() {
        if let data = loadDataFromFile(name: "serie") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject2.description = "Test-modelSerie"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "Test-modelSerie")
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
        }
    
    func testModelForEvent() {
        if let data = loadDataFromFile(name: "event") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject2.description = "Test-modelEvent"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "Test-modelEvent")
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testModelForStory() {
        if let data = loadDataFromFile(name: "story") {
            do {
                let jsonObject1 = try JSONDecoder().decode(Comic.self, from: data)
                let jsonObject2 = try JSONDecoder().decode(Comic.self, from: data)
                jsonObject2.description = "Test-modelStory"
                jsonObject1.populate(item: jsonObject2)
                XCTAssert(jsonObject1.description == "Test-modelStory")
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
}


extension XCTestCase {
    func loadDataFromFile(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: name, withExtension: "json")
        
        let data = try? Data(contentsOf: url!)
        return data
    }
}
