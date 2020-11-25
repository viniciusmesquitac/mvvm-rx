//
//  DocumentCoordinator.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 24/11/20.
//

import UIKit

final class DocumentCoordinator: Coordinator {
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DocumentViewController(viewModel: DocumentViewModel(coordinator: self))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func route(to Path: ListUserPath) {
        // Switch case here
    }
}
