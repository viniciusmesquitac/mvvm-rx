//
//  UserViewModel.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 22/11/20.
//

import RxSwift

struct UserViewModel {
    
    let user: User
    
    init(_ user: User) {
        self.user = user
    }
}

extension UserViewModel {
    
    var userName: Observable<String> {
        return Observable<String>.just(user.userName)
    }
    
    var imageUrl: Observable<String> {
        return Observable<String>.just(user.imageUrl)
    }
    
    var userUrl: Observable<String> {
        return Observable<String>.just(user.userUrl)
    }
    
    var reposUrl: Observable<String> {
        return Observable<String>.just(user.reposUrl!)
    }
    
}
