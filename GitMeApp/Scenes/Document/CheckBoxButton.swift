//
//  CheckboxButton.swift
//  BBNKRegister
//
//  Created by Eduardo Tarallo on 24/11/20.
//  Copyright © 2020 Cubos. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class CheckBoxButton: UIButton {
    
    let checkedImage = R.image.ic_check_box()
    let uncheckedImage = R.image.ic_check_box_outline_blank()
    
    public let isSelectedVariable = BehaviorRelay<Bool>(value: false)
    private var disposeBag = DisposeBag()
    
    public var isChecked = false
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)

        setup()
        isSelectedVariable.asObservable()
            .map { $0 }
            .bind(to: rx.isSelected)
            .disposed(by: disposeBag)
        
        rx.tap.subscribe(onNext: { [weak self] _ in
            guard let this = self else { return }
            this.isSelectedVariable.accept(!this.isSelectedVariable.value)
            this.isChecked = this.isSelectedVariable.value
            this.verifyCheckbox()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        self.imageView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (-self.frame.width + 50)).isActive = true
        self.imageView!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
    }
    
    public func verifyCheckbox() {
        if isChecked {
            self.setImage(checkedImage, for: .normal)
            self.backgroundColor = .black
            self.setTitleColor(.white, for: .normal)
           self.setupLayout()
        } else {
            self.setImage(uncheckedImage, for: .normal)
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.black.cgColor
            self.setupLayout()
        }
    }
    
    private func setup() {
        self.setImage(R.image.ic_check_box_outline_blank(), for: .normal)
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        self.imageView!.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: (-self.frame.width + 50)).isActive = true
        self.imageView!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
    }
}
