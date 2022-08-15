//
//  UnitTestingCommitUseCase_Tests.swift
//  FeunoteTests
//
//  Created by Losd wind on 2022/8/14.
//

import XCTest
@testable import Feunote

class UnitTestingCommitUseCase_Tests: XCTestCase {

    var getOwnedCommitUseCase:GetCommitsUseCaseProtocol = GetOwnedCommitsUseCase()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getOwnedUseCase_execute_shouldReturnArrayofAmplifyCommit() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.


        let page = 0
        let commits = try await getOwnedCommitUseCase.execute(page: page)
        XCTAssertTrue(commits != nil)
    }

    func test_getOwnedUseCase_execute_shouldReturnArrayofAmplifyCommitLargerThanOne() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.


        let page = 0
        let commits = try await getOwnedCommitUseCase.execute(page: page)
        XCTAssertTrue(commits.count > 1)
    }



}
