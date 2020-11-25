//
//  ListUserVIewModel.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import RxSwift
import RxCocoa

protocol DocumentViewModelInput {
    var cnhCheckBoxButton: PublishSubject<Void> { get }
    var rgCheckBoxButton: PublishSubject<Void> { get }
}

protocol DocumentViewModelOutput {
    
}

protocol DocumentViewModelProtocol: ViewModel {
    var inputs: DocumentViewModelInput { get }
    var outputs: DocumentViewModelOutput { get }
}

class DocumentViewModel: DocumentViewModelProtocol, DocumentViewModelInput {
    var rgCheckBoxButton = PublishSubject<Void>()
    var cnhCheckBoxButton = PublishSubject<Void>()
    
    var coordinator: DocumentCoordinator
    var disposeBag = DisposeBag()
    
    var nextPage = PublishSubject<Void>()
    
    var inputs: DocumentViewModelInput { return self }
    var outputs: DocumentViewModelOutput { return self }
    
    init(coordinator: DocumentCoordinator) {
        self.coordinator = coordinator
        
        // MARK: Adiciona o evento do botão
        cnhCheckBoxButton.subscribe(onNext: { _ in
            print("tap em cnh")
        }).disposed(by: disposeBag)
        
        rgCheckBoxButton.subscribe(onNext: { _ in
            print("tap em rg")
        }).disposed(by: disposeBag)
    }
    
}

extension DocumentViewModel: DocumentViewModelOutput {
 
}
