//
//  InterviewTestTests.swift
//  InterviewTestTests
//
//  Created by Surendra P on 22/08/24.
//

import XCTest
@testable import InterviewTest

final class InterviewTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHouseResponseParsing() {
            let jsonData = """
            {
                    "url": "https://anapioficeandfire.com/api/houses/41",
                    "name": "House Breakstone",
                    "region": "The Vale",
                    "coatOfArms": "A red sledge",
                    "words": "",
                    "titles": [],
                    "seats": [],
                    "currentLord": "",
                    "heir": "",
                    "overlord": "",
                    "founded": "",
                    "founder": "",
                    "diedOut": "",
                    "ancestralWeapons": [],
                    "cadetBranches": [],
                    "swornMembers": []
                }
            """.data(using: .utf8)!
            
            do {
                let houseResponse = try JSONDecoder().decode(HouseResponse.self, from: jsonData)
                XCTAssertEqual(houseResponse.name, "House Breakstone")
                XCTAssertEqual(houseResponse.region, "The Vale")
                XCTAssertEqual(houseResponse.coatOfArms, "A red sledge")
            } catch {
                XCTFail("Decoding failed: \(error.localizedDescription)")
            }
        }
    
    func testFetchHouseList() {
        let expectation = self.expectation(description: "Houses data fetched")
        
        NetworkManager.shared.fetchHouseList { result in
            switch result {
            case .success(let houseList):
                XCTAssertNotNil(houseList)
                XCTAssertEqual(houseList.count, 10)
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
