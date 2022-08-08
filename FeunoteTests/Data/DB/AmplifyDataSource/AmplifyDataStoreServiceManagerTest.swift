//
//  AmplifyDataStoreServiceManagerTest.swift
//  FeunoteTests
//
//  Created by Losd wind on 2022/7/6.
//

import XCTest
@testable import Feunote
import Amplify
class AmplifyDataStoreServiceManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SaveBranchFunction_ReturnBranch_EqualsBranch() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let amplifyBranch = AmplifyBranch(id: UUID().uuidString, title: "branch title", description: "branch description", owner: AmplifyUser(username: ""), members: nil, commits: nil, actions: nil, numOfLikes: 1, numOfDislikes: 2, numOfComments: 3, numOfShares: 4, numOfSubs: 5, createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now())
        let dataStoreService = AmplifyDataStoreService()
        
        var returnedAmplifyBranch:AmplifyBranch
//        let expectation = XCTestExpectation(description: "should return item with type of AmplifyBranch")
        
        returnedAmplifyBranch = try await dataStoreService.saveBranch(amplifyBranch)
//        wait(for: [expectation], timeout: 5)
        
        XCTAssert(returnedAmplifyBranch.id == amplifyBranch.id)
        
    }


}
