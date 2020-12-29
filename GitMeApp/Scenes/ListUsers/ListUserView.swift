//
//  ListUserView.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import SnapKit
import UIKit

class ListUserView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let tableView = UITableView(frame: .zero)
    
    // MARK: Setup View
    func setupView() {
        self.backgroundColor = .red
        self.view.frame = self.bounds
        self.view.backgroundColor = .white
        insertSubview(view, belowSubview: indicatorContainer)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        
        self.tableView.backgroundColor = .none
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
