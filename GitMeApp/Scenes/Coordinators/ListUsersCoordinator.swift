//
//  ListUsersCoordinator.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

enum ListUserPath {
    case nextPage
    case backPage
}

final class ListUsersCoordinator: Coordinator {
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ListUsersViewModel(coordinator: self)
        let vc = ListUserViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func route(to Path: ListUserPath) {
        // Switch case here ;-;
    }
}
