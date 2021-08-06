//
//  DataModelTests.swift
//  BitbucketPublicReposTests
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import XCTest
@testable import BitbucketPublicRepos

class DataModelTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testMockResponse() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MockRepos", withExtension: "json") else {
            XCTFail("Unable to find MockRepos.json file")
            return
        }
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        let response = try JSONDecoder().decode(Repositories.self, from: data)
        XCTAssertNotNil(response.next)
        XCTAssertEqual(response.repos?.count, 2)
        
        let repo = response.repos?.first
        XCTAssertEqual(repo?.fullName, "mrdon/jira4-compat")
        XCTAssertEqual(repo?.name, "jira4-compat")
        
        let owner = repo?.owner
        XCTAssertNotNil(owner?.links?.avatarLink)
        XCTAssertEqual(owner?.nickName, "DonB")
    }
}
