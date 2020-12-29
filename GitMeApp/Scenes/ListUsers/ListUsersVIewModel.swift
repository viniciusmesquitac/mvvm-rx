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
        // Subscribing an event
        outputs.usersListOutput.subscribe { value in
            self.appendUsers()
        }.disposed(by: disposeBag)
    }
    
    private func appendUsers() {
        let resource = Resource<[User]>(url: GitHubAPI.allUsers.url!)
        // API Request.
        URLRequest.load(resource: resource)
            .subscribe(onNext: { listUser in
                // add on input a new value
                listUser?.forEach { self.data.append($0) }
                self.inputs.userListRelay.accept(self.data)
            }).disposed(by: self.disposeBag)
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
    
    enum ScrollRow {
        static var start = 29
        static let max = 90
        
        static func update() {
            ScrollRow.start += 29
        }
    }
    
    func userAt(_ index: Int) -> User {
        if index == ScrollRow.start && index < ScrollRow.max {
            // Trigger timer and loading.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.appendUsers()
                ScrollRow.update()
            }
        }
        return self.data[index]
    }
}

extension ListUsersViewModel {
    
    func populateMockUsers() {
        // Subscribing an event
        outputs.usersListOutput.subscribe { value in
            let data = User().createMockUsers()
            self.data = data
            self.inputs.userListRelay.accept(data)
        }.disposed(by: disposeBag)
    }
    
    func appendMockUsers() {
        let data = User().createMockUsers(in: ScrollRow.start..<ScrollRow.start)
        data.forEach { self.data.append($0) }
        self.inputs.userListRelay.accept(self.data)
    }
    
}
