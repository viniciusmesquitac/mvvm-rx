//
//  GitHubAPI.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import Foundation

protocol Router {
    var hostname: String { get }
    var url: URL? { get }
}

enum GitHubAPI: Router {

    case allUsers
    case infoUser(username: String)
    
    var hostname: String {
        get {
            return "https://api.github.com"
        }
    }
    
    var url: URL? {
        get {
            switch self {
            case .allUsers: return URL(string: "\(hostname)/users?since=3")
            case .infoUser(let username): return URL(string: "\(hostname)/\(username)")
            }
        }
    }
}
