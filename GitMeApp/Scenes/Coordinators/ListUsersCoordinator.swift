//
//  ListUsersCoordinator.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

final class ListUsersCoordinator: Coordinator {
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListUserViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
