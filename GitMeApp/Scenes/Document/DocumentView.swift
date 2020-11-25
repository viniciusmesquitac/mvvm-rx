//
//  ListUserView.swift
//  GitMeApp
//
//  Created by Vinicius Mesquita on 21/11/20.
//

import SnapKit
import UIKit
import RxSwift

class DocumentView: UIView {
    
    let view = UIView(frame: .zero)
    let indicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let cnhCheckBoxButton = CheckBoxButton(title: "CNH")
    let rgCheckBoxButton = CheckBoxButton(title: "RG")

    let disposedBag = DisposeBag()
    var isFirstTimeSelected = true
    var isCnhButtonSelected = false
    var isRgButtonSelected = false
    
    // MARK: Setup View
    func setupView() {
        self.backgroundColor = .white
        self.view.frame = self.bounds
        
        insertSubview(view, belowSubview: indicatorContainer)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupcnhCheckBoxButtonView()
    }
    
    func setupcnhCheckBoxButtonView() {
        addSubview(cnhCheckBoxButton)
        
        self.cnhCheckBoxButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(56)
        }
        
        cnhCheckBoxButton.isSelectedVariable.asObservable().subscribe(onNext: { [weak self] selected in
            guard let this = self else { return }
            if selected {
                this.isCnhButtonSelected = selected
                this.isRgButtonSelected = false
                this.verifyButtonSelected()
                
                if !this.isFirstTimeSelected {
                    this.rgCheckBoxButton.isSelectedVariable.accept(false)
                }
                
                this.isFirstTimeSelected = false
                print("cnh selected")
            } else {
                this.cnhCheckBoxButton.isChecked = false
                this.isCnhButtonSelected = false
                this.verifyButtonSelected()
                print("cnh deselected")
            }
            
        }).disposed(by: disposedBag)
        
        setuprgCheckBoxButtonView()
    }
    
    func setuprgCheckBoxButtonView() {
        addSubview(rgCheckBoxButton)
        
        self.rgCheckBoxButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(cnhCheckBoxButton.snp.bottom).offset(-60)
            make.height.equalTo(56)
        }
        
        rgCheckBoxButton.isSelectedVariable.asObservable().subscribe(onNext: { [weak self] selected in
            guard let this = self else { return }
            
            if selected {
                this.isRgButtonSelected = selected
                this.isCnhButtonSelected = false
                this.verifyButtonSelected()
                
                if !this.isFirstTimeSelected {
                    this.cnhCheckBoxButton.isSelectedVariable.accept(false)
                }
                
                this.isFirstTimeSelected = false
                print("rg selected")
            } else {
                this.rgCheckBoxButton.isChecked = false
                this.isRgButtonSelected = false
                this.verifyButtonSelected()
                print("rg deselected")
            }
            
        }).disposed(by: disposedBag)
        
    }
    
    func verifyButtonSelected() {
        
        if isCnhButtonSelected && isFirstTimeSelected {
            print("apenas a primeira vez")
            self.isFirstTimeSelected = false
            self.isCnhButtonSelected = true
            
        } else if isCnhButtonSelected {
            self.rgCheckBoxButton.isChecked = false
            self.cnhCheckBoxButton.isChecked = true
            self.rgCheckBoxButton.verifyCheckbox()
        }
        
        if isRgButtonSelected && isFirstTimeSelected {
            print("apenas a primeira vez")
            self.isFirstTimeSelected = false
            self.isRgButtonSelected = true
        } else if isRgButtonSelected {
            self.rgCheckBoxButton.isChecked = true
            self.cnhCheckBoxButton.isChecked = false
            self.cnhCheckBoxButton.verifyCheckbox()
        }
    }

}
