//
//  RepoInteractorTests.swift
//  BitbucketPublicReposTests
//
//  Created by Baveendran Nagendran on 2021-08-06.
//

import XCTest
@testable import BitbucketPublicRepos

class RepoInteractorTests: XCTestCase {
    var interactor: RepoInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = RepoInteractor(client: MockAPIClient(baseUrl: ""))
    }

    override func tearDownWithError() throws {
        interactor = nil
        try super.tearDownWithError()
    }

    func testProperties() {
        interactor.fetchRepos(url: "abcd")
        XCTAssertNotNil(interactor.client.baseURL)
        XCTAssertNotNil(interactor.nextUrl)
        XCTAssertTrue(interactor.publicRepos?.count == 0)
    }
    func testFetchRepos() {
        interactor.fetchRepos(url: "")
        XCTAssertTrue(interactor.publicRepos?.count == 2)
    }

}
