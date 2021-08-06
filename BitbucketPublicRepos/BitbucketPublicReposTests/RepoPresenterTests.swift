//
//  RepoPresenterTests.swift
//  BitbucketPublicReposTests
//
//  Created by Baveendran Nagendran on 2021-08-06.
//

import XCTest
@testable import BitbucketPublicRepos

class RepoPresenterTests: XCTestCase {

    var presenter: RepoPresenter!
    var interactor: RepoInteractor!
    var mockView: MockView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockView = MockView()
        presenter = RepoPresenter()
        interactor = RepoInteractor(client: MockAPIClient(baseUrl: ""))

        mockView.presenter = presenter
        presenter.view = mockView
        presenter.interactor = interactor
        interactor.presenter = presenter
        
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockView = nil
        presenter = nil
        
        try super.tearDownWithError()
    }

    func testProperties() {
        interactor.fetchRepos(url: "abcd")
        XCTAssertFalse(presenter.isDataAvailable)
    }
    
    func testFetchRepos() {
        interactor.fetchRepos(url: "")
        XCTAssertTrue(presenter.isDataAvailable)
    }

}

class MockView: PresenterToViewProtocol {
    var presenter: ViewToPresenterProtocol?

    func showFetchFailedMessage(message: String) {
        
    }
    
    func showFetchedRepos(repos: [PublicRepo]) {
    }
    
    func updateDataAvailablity(_ available: Bool) {
    }
    
}
