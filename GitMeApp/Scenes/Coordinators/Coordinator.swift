//
//  Coordinator.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
