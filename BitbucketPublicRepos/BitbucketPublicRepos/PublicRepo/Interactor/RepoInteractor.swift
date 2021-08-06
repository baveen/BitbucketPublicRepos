//
//  RepoInteractor.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import Foundation
import UIKit

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    var nextUrl: String? {get set }
    var publicRepos: [PublicRepo]? { get set }
    
    func fetchRepos(url: String?)
}

protocol InteractorToPresenterProtocol: AnyObject {
    var interactor: PresenterToInteractorProtocol? {get set}
    var isDataAvailable: Bool {get set}
   
    func reposFetched()
    func fetchFailed(error: Error)
}

class RepoInteractor: PresenterToInteractorProtocol {
    
    var client: ClientProtocol
    
    weak var presenter: InteractorToPresenterProtocol?
    var publicRepos: [PublicRepo]?
    var nextUrl: String? {
        didSet {
            if let url = nextUrl, url != "" {
                presenter?.isDataAvailable = true
            } else {
                presenter?.isDataAvailable = false
            }
        }
    }
    
    init(client: ClientProtocol = APIClient(baseUrl: "https://api.bitbucket.org/2.0/repositories")) {
        self.client = client
        self.nextUrl = client.baseURL
    }
    
    func fetchRepos(url: String?) {
        client.getData(urlString: url) { data, error in
            if let error = error {
                self.publicRepos = []
                self.presenter?.fetchFailed(error: error)
                return
            }
            if let respData = data, let repositories = try? JSONDecoder().decode(Repositories.self, from: respData) {
                self.nextUrl = repositories.next
                self.publicRepos = repositories.repos
                self.presenter?.reposFetched()
            }
        }
    }
}
