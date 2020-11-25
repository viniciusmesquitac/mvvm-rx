//
//  ButtonViewController.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 24/11/20.
//

import UIKit
import RxSwift
import RxCocoa

class DocumentViewController: UIViewController {

    let mainView = DocumentView()
    var viewModel: DocumentViewModel!
    
    let disposeBag = DisposeBag()

    init(viewModel: DocumentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setupView()
        self.view = mainView
        setup()
    }

}

extension DocumentViewController {
    
    func setup() {
        setupInputs()
        setupOutputs()
    }
    
    private func setupOutputs() {

    }
    
    private func setupInputs() {
        mainView.cnhCheckBoxButton.rx.tap.bind(to: viewModel.inputs.cnhCheckBoxButton).disposed(by: disposeBag)
        mainView.rgCheckBoxButton.rx.tap.bind(to: viewModel.inputs.rgCheckBoxButton).disposed(by: disposeBag)

    }
    
}
