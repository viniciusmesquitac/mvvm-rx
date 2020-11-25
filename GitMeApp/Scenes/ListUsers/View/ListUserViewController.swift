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
        mainView.tableView.register(ListUserViewCell.self, forCellReuseIdentifier: ListUserViewCell.identifier)
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
    
    private func setupOutputs() {
        
        viewModel.outputs.usersListOutput
            .bind(to: mainView.tableView.rx
                    .items(cellIdentifier: ListUserViewCell.identifier,
                           cellType:ListUserViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(self.viewModel.userAt(row).user.userName)"

            }.disposed(by: disposeBag)
    }
    
    private func setupInputs() { }
    
}

/* Resource:
 
 https://benoitpasquier.com/advanced-concepts-uitableview-rxdatasource/
 
 
 */
