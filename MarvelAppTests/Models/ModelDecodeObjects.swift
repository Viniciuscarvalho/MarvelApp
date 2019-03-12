//
//  ModelDecodeObjects.swift
//  MarvelAppTests
//
//  Created by Vinicius Marques on 25/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ModelDecodeObjects: XCTestCase {
    
    func testComic() {
        if let data = loadDataFromFile(name: "comic") {
            do {
                let jsonObject = try JSONDecoder().decode(Comic.self, from: data)
                XCTAssertNotNil(jsonObject)
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testSerie() {
        if let data = loadDataFromFile(name: "serie") {
            do {
                let jsonObject = try JSONDecoder().decode(Serie.self, from: data)
                XCTAssertNotNil(jsonObject)
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testStory() {
        if let data = loadDataFromFile(name: "story") {
            do {
                let jsonObject = try JSONDecoder().decode(Story.self, from: data)
                XCTAssertNotNil(jsonObject)
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testEvent() {
        if let data = loadDataFromFile(name: "event") {
            do {
                let jsonObject = try JSONDecoder().decode(Event.self, from: data)
                XCTAssertNotNil(jsonObject)
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
    func testCharacter() {
        if let data = loadDataFromFile(name: "character") {
            do {
                let jsonObject = try JSONDecoder().decode(Character.self, from: data)
                XCTAssertNotNil(jsonObject)
                return
            } catch let e {
                print(e)
            }
        }
        XCTAssert(false)
    }
    
}
