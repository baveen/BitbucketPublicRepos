//
//  APIClientTests.swift
//  BitbucketPublicReposTests
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import XCTest
@testable import BitbucketPublicRepos

class APIClientTests: XCTestCase {
    var client: ClientProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        client = MockAPIClient(baseUrl: "testingurl")
    }

    override func tearDownWithError() throws {
        client = nil
        try super.tearDownWithError()
    }
    
    func testGetData() {
        client.getData(urlString: client.baseURL ?? "") { data in
            XCTAssertNotNil(data)
        } failure: { error in
            XCTFail("Mock loading failed")
        }
    }
}

class MockAPIClient: ClientProtocol {
    var baseURL: String?
    
    required init(baseUrl: String) {
        print("\(baseUrl)")
    }
    
    func getData(urlString: String,
                 success: @escaping (Data) -> (),
                 failure: @escaping (Error?) -> ()) {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MockRepos", withExtension: "json") else {
            XCTFail("Unable to find MockRepos.json file")
            return
        }
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            let error = NSError(domain: "om.rbtechsolutions.SampleBitBucketRep.mock", code: 1005, userInfo: ["mockFailed" : "Unable to Fetch Data"])
            failure(error)
            return
        }
        success(data)
    }
}
