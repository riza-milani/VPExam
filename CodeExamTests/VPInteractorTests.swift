//
//  VPInteractorTests.swift
//  CodeExamTests
//
//  Created by riza milani on 11/17/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import XCTest
@testable import CodeExam

class VPInteractorTests: XCTestCase {

    var vpInteractor: VPInteractor?

    override func setUp() {
        vpInteractor = VPInteractor(service: ServiceCallMock())
        
    }

    override func tearDown() {
        vpInteractor = nil
    }

    func testFetchSections() {
        let asyncExpectation = expectation(description: "testFetchSections")
        vpInteractor?.fetchSections { result in
            switch result {
            case .success(let vpSections):
                XCTAssertEqual(vpSections.count, 6)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            asyncExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionSerier() {
        let asyncExpectation = expectation(description: "testSectionSerier")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/serier{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "TV-serier online - Streama serier på nätet eller ladda ned")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionSport() {
        let asyncExpectation = expectation(description: "testSectionSport")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/sport{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "Sport online - Streama Premier & Champions league live - Viaplay.se")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionSport2() {
        let asyncExpectation = expectation(description: "testSectionSport2")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/sport2{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "Sport online - Streama Premier & Champions league live - Viaplay.se")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionSport3() {
        let asyncExpectation = expectation(description: "testSectionSport3")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/sport3{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "Sport online - Streama Premier & Champions league live - Viaplay.se")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionFilm() {
        let asyncExpectation = expectation(description: "testSectionFilm")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/film{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "Film på nätet - Streama film online eller ladda ned")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSectionBarn() {
        let asyncExpectation = expectation(description: "testSectionBarn")
        vpInteractor?.fetchSectionDetail(href: "https://content.viaplay.se/ios-se/barn{?dtg}") { vpModel in
            guard let vpModel = vpModel else {
                XCTFail()
                return
            }
            XCTAssertEqual(vpModel.title, "Barnfilmer och serier för barn på nätet – Viaplay.se")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

}
