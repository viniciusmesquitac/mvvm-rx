//
//  ListUserViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit

class ListUserViewController: UIViewController {

    let mainView = ListUserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        
    }
    

}
