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
        
        client = MockAPIClient(baseUrl: "")
    }

    override func tearDownWithError() throws {
        client = nil
        try super.tearDownWithError()
    }
    
    func testGetData() {
        client.getData(urlString: client.baseURL ?? "") { data, error in
            XCTAssertNotNil(data)
        }
    }
}

class MockAPIClient: ClientProtocol {    
    var baseURL: String?
    
    required init(baseUrl: String) {
        self.baseURL = baseUrl
    }
    
    func getData(urlString: String?, completion: @escaping (Data?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        var path = "MockRepos"
        let error = NSError(domain: "om.rbtechsolutions.SampleBitBucketRep.mock", code: 1005, userInfo: ["mockFailed" : "Unable to Fetch Data"])
        if let str = urlString, str != "" {
            path = str
        }
        guard let url = bundle.url(forResource: path, withExtension: "json") else {
            completion(nil, error)
            return
        }
        
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            completion(nil, error)
            return
        }
        completion(data,nil)
    }
}
