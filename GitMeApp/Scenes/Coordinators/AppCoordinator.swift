//
//  AppCoordinator.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        coordinateToListUsers()
    }
    
    private func coordinateToListUsers() {
        let listUsers = DocumentCoordinator(navigationController: navigationController)
        coordinate(to: listUsers)
    }
    
}
