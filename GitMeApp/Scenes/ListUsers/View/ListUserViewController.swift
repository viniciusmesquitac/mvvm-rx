//
//  ListUserViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

class ListUserViewController: UIViewController {

    let mainView = ListUserView()
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Users"
        mainView.setupView()
        self.view = mainView
    }
}
