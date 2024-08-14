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
        let view = DropDownView()
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
    
    lazy var filterButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "up"), for: .normal)
        searchButton.frame.size = CGSize(width: 38, height: 38)
        searchButton.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
        
        return searchButton
    }()
    
    lazy var filterButton2: UIBarButtonItem = {
        let searchButton = UIButton()
        searchButton.frame.size = CGSize(width: 38, height: 38)
        searchButton.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
        
        let button = UIBarButtonItem(customView: searchButton)
        button.image = UIImage(named: "up")
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navButton = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = navButton
        navigationController?.navigationBar.backgroundColor = .systemPink.withAlphaComponent(0.1)
        globalView.dataSource = []
        addViews()
        setupLayouts()
        bindViews()
        let vc = SecondViewController()
        vc.delegate = self
        globalView.didSelect(completion: { selectedText, index in
            print(">>> selectedText \(selectedText) \n >>> index \(index)")
        })
        
        globalView.didSelectLastCell(self, vc) {
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    @objc
    func changeBackgroundColor() {
        if self.view.backgroundColor == .white {
            self.view.backgroundColor = .green.withAlphaComponent(0.1)
        } else {
            self.view.backgroundColor = .white
        }
//        filterButton.setImage(UIImage(named: "up"),
//                              for: .normal)
        navigationItem.rightBarButtonItem?.image = UIImage(named: "up")
    }
    
    @objc
    func onSaveButtonTap() {
        globalView.checkValidField()
//        UINavigationBar.appearance().items?.first?.rightBarButtonItem?.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal)
//        navigationItem.rightBarButtonItem?.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal)
//        print(">>>")
//        navigationController?.navigationItem.rightBarButtonItem?.image = UIImage(named: "down")
//        navigationController?.navigationBar.items?.last?.rightBarButtonItem?.image = UIImage(named: "down")
//        navigationItem.rightBarButtonItem = nil

//        filterButton.setImage(UIImage(named: "down"),
//                              for: .normal)
//        navigationItem.setRightBarButtonItems([filterButton], animated: true)
//        navigationItem.rightBarButtonItem?.setBackgroundImage(UIImage(named: "down"),
//                                                              for: .normal,
//                                                              barMetrics: .default)
        navigationItem.rightBarButtonItem?.image = UIImage(named: "down")
    }
}

extension DropDownViewController: PassTextProtocol {
    
    func passText(_ newAdress: String) {
        globalView.newAdress(newAdress)
    }
}
