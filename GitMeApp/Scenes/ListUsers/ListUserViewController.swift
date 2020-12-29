//
//  ListUserViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import UIKit
import RxSwift
import RxCocoa

class ListUserViewController: UIViewController {

    let mainView = ListUserView()
    var viewModel: ListUsersViewModel!
    
    let disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    init(viewModel: ListUsersViewModel) {
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
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel.populateUsers()
        self.view = mainView
        setup()
    }
    
}

extension ListUserViewController {
    
    func setup() {
        setupInputs()
        setupOutputs()
    }
    
    private func setupOutputs() { }
    
    private func setupInputs() {
        
        // bind view model inputs
        viewModel.inputs.userListRelay.asObservable()
            .bind(to: mainView.tableView.rx
                    .items(cellIdentifier: "Cell",
                           cellType: UITableViewCell.self)) { row, element, cell in

                cell.textLabel?.text = "\(self.viewModel.userAt(row).userName)"

            }.disposed(by: disposeBag)
    }
    
}
