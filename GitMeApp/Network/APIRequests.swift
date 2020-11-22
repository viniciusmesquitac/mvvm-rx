//
//  APIRequests.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 22/11/20.
//

import RxSwift

class API {
    
    let disposeBag = DisposeBag()
    
    func getAllUsers() {
        
        guard let url = GitHubAPI.allUsers.url else { fatalError("Invalid URL") }
        
        let resource = Resource<[User]>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
    }
    
}
