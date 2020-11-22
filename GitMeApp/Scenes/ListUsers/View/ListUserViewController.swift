//
//  ListUserViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit
import RxSwift

class ListUserViewController: UIViewController {

    let mainView = ListUserView()
    var viewModel: ListUsersViewModelProtocol!
    
    let disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    init(viewModel: ListUsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Users"
        
        populateUsers()
        
        mainView.setupView()
        self.view = mainView
    }
    
    func populateUsers() {
        guard let url = GitHubAPI.allUsers.url else { fatalError("Invalid URL") }
        
        let resource = Resource<[User]>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
    }
    
}
