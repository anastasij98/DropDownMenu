//
//  SecondViewController.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 09.10.23.
//

import Foundation
import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите адрес доставки"
        textField.layer.borderColor = UIColor(red: 0.329,
                                              green: 0.557,
                                              blue: 1,
                                              alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить",
                        for: .normal)
        button.addTarget(self,
                         action: #selector(onSaveButtonTap),
                         for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.329,
                                          green: 0.557,
                                          blue: 1,
                                          alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    @objc
    func onSaveButtonTap() {
        print(">>>saved")
    }
    
    func setupView() {
        view.addSubview(textField)
        view.addSubview(saveButton)

        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(100)
            $0.height.equalTo(50)
        }
    }
}


extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
