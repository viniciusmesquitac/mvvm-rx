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
    var userListRelay: BehaviorRelay<[User]> { get }
}

protocol ListUsersViewModelOutput {
    var usersListOutput: Observable<[User]> { get }
    var userListDriver: Driver<[User]> { get }
}

protocol ListUsersViewModelProtocol: ViewModel {
    var inputs: ListUsersViewModelInput { get }
    var outputs: ListUsersViewModelOutput { get }
    func populateUsers()
}

class ListUsersViewModel: ListUsersViewModelProtocol, ListUsersViewModelInput {
    var userListRelay = BehaviorRelay<[User]>(value: [])
    
    var coordinator: ListUsersCoordinator
    var disposeBag = DisposeBag()
    
    var nextPage = PublishSubject<Void>()
    
    var inputs: ListUsersViewModelInput { return self }
    var outputs: ListUsersViewModelOutput { return self }
    
    var users: [UserViewModel]
    var data: [User]
    
    init(coordinator: ListUsersCoordinator, data: [User]) {
        self.coordinator = coordinator
        self.users = data.compactMap (UserViewModel.init)
        self.data = data
        // Add Events
        nextPage.subscribe { _ in
            // Can create another route in coordinator.
            print("nextPageButton Touched!")
        }.disposed(by: disposeBag)

    }
    
    func populateUsers() {
        let resource = Resource<[User]>(url: GitHubAPI.allUsers.url!)
        // Subscribing an event
        outputs.usersListOutput.subscribe { value in
            // API Request.
            URLRequest.load(resource: resource)
                .subscribe(onNext: { listUser in
                    // add on input a new value
                    self.data = listUser!
                    self.inputs.userListRelay.accept(listUser!)
                })
        }.disposed(by: disposeBag)
    }
    
}

extension ListUsersViewModel: ListUsersViewModelOutput {
    
    var usersListOutput: Observable<[User]> {
        Observable.of(self.data)
    }
    
    var userListDriver: Driver<[User]> {
        self.inputs.userListRelay.accept(self.data)
        return Driver.just(self.data)
    }
}

extension ListUsersViewModel {
    
    func userAt(_ index: Int) -> User {
        return self.data[index]
    }
    
}
