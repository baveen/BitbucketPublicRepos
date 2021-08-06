//
//  AppDelegate.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let reposVC = RepoRouter.createModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = reposVC
        window?.makeKeyAndVisible()
        return true
    }
}

