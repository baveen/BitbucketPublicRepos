//
//  RepoRouter.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import Foundation
import UIKit

class RepoRouter: PresenterToRouterProtocol {
    static func createModule() -> UIViewController {
        let view = ReposViewController()
        let presenter = RepoPresenter()
        let interactor = RepoInteractor()
        let router = RepoRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

}
