//
//  ListUserVIewModel.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import RxSwift
import RxCocoa

protocol ListUsersViewModelInput {
    var nextPage: PublishSubject<Void> { get }
}

protocol ListUsersViewModelOutput {
    var userNameObservable: Observable<String> { get }
}

protocol ListUsersViewModelProtocol: ViewModel {
    var inputs: ListUsersViewModelInput { get }
    var outputs: ListUsersViewModelOutput { get }
}

class ListUsersViewModel: ListUsersViewModelProtocol, ListUsersViewModelInput {
    
    var coordinator: ListUsersCoordinator
    var disposeBag = DisposeBag()
    
    var nextPage = PublishSubject<Void>()
    
    var inputs: ListUsersViewModelInput { return self }
    var outputs: ListUsersViewModelOutput { return self }
    
    init(coordinator: ListUsersCoordinator) {
        self.coordinator = coordinator
        
        // Add Events
        nextPage.subscribe { _ in
            // Can create another route in coordinator.
            print("nextPageButton Touched!")
        }.disposed(by: disposeBag)

    }
}


extension ListUsersViewModel: ListUsersViewModelOutput {
    var userNameObservable: Observable<String> {
        self.outputs.userNameObservable.asObservable()
    }
}
