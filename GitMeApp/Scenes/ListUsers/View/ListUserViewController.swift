//
//  ListUserViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

class ListUserViewController: UIViewController {

    let mainView = ListUserView()
    var viewModel: ListUsersViewModelProtocol!
    
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
        mainView.setupView()
        self.view = mainView
    }
    
}
