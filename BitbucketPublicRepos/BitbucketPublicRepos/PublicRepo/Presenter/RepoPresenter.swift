//
//  RepoPresenter.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import Foundation
import UIKit

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? {get set}
    func loadRepos()
}

protocol PresenterToViewProtocol: AnyObject {
    var presenter: ViewToPresenterProtocol? {get set}
    
    func showFetchFailedMessage(message: String)
    func showFetchedRepos(repos: [PublicRepo])
    func updateDataAvailablity(_ available: Bool)
}


class RepoPresenter: InteractorToPresenterProtocol, ViewToPresenterProtocol {
    var isDataAvailable: Bool = false {
        didSet {
            view?.updateDataAvailablity(isDataAvailable)
        }
    }
        
    var interactor: PresenterToInteractorProtocol?
    weak var view: PresenterToViewProtocol?
    var router: PresenterToRouterProtocol?
    
    func reposFetched() {
        view?.showFetchedRepos(repos: interactor?.publicRepos ?? [])
    }
    
    func loadRepos() {
        interactor?.fetchRepos(url: interactor?.nextUrl)
    }
    
    func fetchFailed(error: Error) {
        let err = error as NSError
        view?.showFetchFailedMessage(message: err.userInfo["fetchFailed"] as! String)
    }
    
}
