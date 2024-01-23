//
//  ViewController.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 24.08.23.
//

import UIKit
import SnapKit

class DropDownViewController: UIViewController, UIGestureRecognizerDelegate {

    lazy var globalView: DropDownView = {
        let view = DropDownView(adressesArray: ["1", "2", "3"])
        return view
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(onSaveButtonTap),
                         for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.329,
                                          green: 0.557,
                                          blue: 1,
                                          alpha: 1)

        button.layer.cornerRadius = 10
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    var adressesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupLayouts()
        bindViews()
        globalView.didSelect(completion: { selectedText, index in
            print(">>> selectedText \(selectedText) \n >>> index \(index)")
        })
        globalView.didSelectLastCell {
            self.changeBackgroundColor()
        }
    }

    func addViews() {
        view.addSubview(globalView)
        view.addSubview(saveButton)
    }

    func setupLayouts() {
        globalView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
    }
    
    func bindViews() {
        self.view.backgroundColor = .white
        saveButton.addTarget(self,
                             action: #selector(onSaveButtonTap),
                             for: .touchUpInside)
    }
    
    func changeBackgroundColor() {
        if self.view.backgroundColor == .white {
            self.view.backgroundColor = .green.withAlphaComponent(0.1)
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    @objc
    func onSaveButtonTap() {
        print(">>> saved")
    }
}

extension DropDownViewController: PassTextProtocol {
    
    func passText(_ newAdress: String) {
        adressesArray.append(newAdress)
//        dropTableView.reloadData()
    }
}
