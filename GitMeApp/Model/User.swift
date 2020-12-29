//
//  User.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import Foundation

struct User: Decodable {
    var userName: String
    let imageUrl: String
    let userUrl: String
    let reposUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case imageUrl = "avatar_url"
        case userUrl = "url"
        case reposUrl = "repos_url"
    }
    
    init() {
        userName = "User"
        imageUrl = ""
        userUrl = ""
        reposUrl = ""
    }
}

extension User {
    
    func createMockUsers(in range: Range<Int> = 0..<16) -> [User] {
        var users = [User]()
        for index in range {
            var user = User()
            user.userName = "User \(index)"
            users.append(user)
        }
        return users
    }
}


/** Example of User from API Github
 
 {
   "login": "octocat",
   "id": 1,
   "node_id": "MDQ6VXNlcjE=",
   "avatar_url": "https://github.com/images/error/octocat_happy.gif",
   "gravatar_id": "",
   "url": "https://api.github.com/users/octocat",
   "html_url": "https://github.com/octocat",
   "followers_url": "https://api.github.com/users/octocat/followers",
   "following_url": "https://api.github.com/users/octocat/following{/other_user}",
   "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
   "organizations_url": "https://api.github.com/users/octocat/orgs",
   "repos_url": "https://api.github.com/users/octocat/repos",
   "events_url": "https://api.github.com/users/octocat/events{/privacy}",
   "received_events_url": "https://api.github.com/users/octocat/received_events",
   "type": "User",
   "site_admin": false
 }
 
 */
