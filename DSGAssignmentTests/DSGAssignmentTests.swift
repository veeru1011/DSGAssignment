//
//  DSGAssignmentTests.swift
//  DSGAssignmentTests
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import XCTest
@testable import DSGAssignment

class DSGAssignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearchAPI() {
        let promise = expectation(description: "events")
        var eventsResponse: [Event]?
        APIManager.shared().getSearchResult(query: "swift") { (success, info, message) in
            switch success {
            case true :
                if let i = info as? Events, let list = i.list {
                    XCTAssertTrue(success, "data fetch successfully")
                    XCTAssertEqual(message, "")
                    eventsResponse = list
                    promise.fulfill()
                }
            case false:
                XCTAssertFalse(success, "error in data fetching from server")
            }
        }
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNotNil(eventsResponse)
        }
    }
    
    func testSearchAPIwithViewModel() {
        
        let viewModel = SearchViewModel()
        let eventsExpectation = expectation(description: "events")
        var eventsResponse: [Event]?
        var errorStr: String?
        
        viewModel.dataChange.bind { _ in
            eventsResponse = viewModel.eventsList
            XCTAssertTrue(viewModel.eventsList.count > 0, "")//Check list should have some values
            eventsExpectation.fulfill()
        }
        viewModel.errorMessage.bind { errorString in
            XCTAssertFalse(errorString.isEmpty, "error in data fetching from server")
            errorStr = errorString
            eventsExpectation.fulfill()
        }
        
        viewModel.queryString = "swift"
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertTrue((eventsResponse != nil) || (errorStr != nil))
        }
    }

}
