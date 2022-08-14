//
//  UnitTestingDataStoreServiceImpl.swift
//  FeunoteTests
//
//  Created by Losd wind on 2022/8/14.
//

import XCTest
@testable import Feunote

class UnitTestingDataStoreServiceImpl: XCTestCase {
    var dataStoreService:DataStoreServiceProtocol = AmplifyDataStoreService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_query_shouldReturnCommitsMoreThanZero() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let commits = try await  dataStoreService.query(AmplifyCommit.self, where: nil, sort: nil, paginate: nil)
        XCTAssertTrue(commits.count > 0)
    }

    func test_queryByID_shouldReturnCommitWithSpecificID() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let id:String = "881827D7-621B-4ECD-98CC-55D0D8E238B3"
        guard let commit = try await dataStoreService.query(AmplifyCommit.self, byId: id) else {
            XCTFail("did not get the commit with your id")
            return
        }
        XCTAssertEqual(id, commit.id)
    }

    func test_query_shouldReturnBranchesMorethanZero() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let branches = try await  dataStoreService.query(AmplifyBranch.self, where: nil, sort: nil, paginate: nil)
        print("branches: \(branches)")
        XCTAssertTrue(branches.count > 0)
    }

}
