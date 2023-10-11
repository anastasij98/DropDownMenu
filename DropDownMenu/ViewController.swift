//
//  ViewController.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 24.08.23.
//

import UIKit
import SnapKit

class DropDownViewController: UIViewController, CustomCellDelegate {

    lazy var globalView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 0.329,
                                         green: 0.557,
                                         blue: 1,
                                         alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = "Адрес доставки"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.677,
                                  green: 0.732,
                                  blue: 0.804,
                                  alpha: 1)
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down")
        return imageView
    }()
    
    lazy var smallLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.329,
                                  green: 0.557,
                                  blue: 1,
                                  alpha: 1)
        label.backgroundColor = .white
        label.isHidden = true
        return label
    }()

    lazy var dropTableView: UITableView = {
        let tabelView = UITableView(frame: .zero, style: .plain)

        return tabelView
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
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.textColor = UIColor(red: 0.958, green: 0.504, blue: 0.475, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    
//    var adressesArray = ["ул. Большая Садовая",
//                         "пр. Кировский",
//                         "пр. Ворошиловский",
//                         "ул. Зорге",
//                         "ул. Извилистая",
//                         "пл. Ленина",
//                         "бул. Комарова",
//                         "пр. Королёва"]
    var adressesArray: [String] = []

    let headerView = DropDownHeader()
    var isTabelViewSmall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        setupLayouts()
        setupAdressLabel()
        setupTabelView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        changeTableViewSize()
    }

    func addViews() {
        view.addSubview(globalView)
        globalView.addSubview(adressLabel)
        globalView.addSubview(dropTableView)
        adressLabel.addSubview(arrowImage)
        view.addSubview(smallLabel)
        view.addSubview(errorLabel)
        view.addSubview(saveButton)
    }
    
    func setupLayouts() {
        globalView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
            $0.height.equalTo(48)
        }
        
        adressLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            $0.top.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        smallLabel.snp.makeConstraints({
            $0.bottom.equalTo(adressLabel.snp.top).inset(9)
            $0.leading.equalTo(globalView.snp.leading).inset(20)
            $0.height.equalTo(18)
            $0.width.equalTo(95)
        })

        dropTableView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(adressLabel.snp.bottom)
            $0.bottom.equalTo(globalView.snp.bottom)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(globalView.snp.bottom).inset(15)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(36)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(150)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }

    func setupAdressLabel() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureForAdressLabel))
        adressLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupTabelView() {
        dropTableView.delegate = self
        dropTableView.dataSource = self
        dropTableView.tintColor = .black
        dropTableView.separatorStyle = .none
        
        dropTableView.contentInsetAdjustmentBehavior = .never
        
        dropTableView.register(DropDownCell.self,
                               forCellReuseIdentifier: DropDownCell.reuseIdentifier)
        dropTableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "UITableViewCell")
        dropTableView.register(ButtonCell.self,
                               forCellReuseIdentifier: ButtonCell.reuseIdentifier)
    }
    
    @objc
    func gestureForAdressLabel() {
        changeTableViewSize()
    }
    
    @objc
    func onSaveButtonTap() {
        if let text = adressLabel.text,
           text.contains("Адрес доставки") {
            globalView.layer.borderColor = UIColor.red.cgColor
            errorLabel.isHidden = false
        } else {
            globalView.layer.borderColor = UIColor(red: 0.329,
                                                   green: 0.557,
                                                   blue: 1,
                                                   alpha: 1).cgColor
            errorLabel.isHidden = true
        }
    }
    
    func changeHeaderTitle(_ indexPath: Int) {
        adressLabel.text = adressesArray[indexPath]
        adressLabel.textColor = .black
    }
    
    func changeTableViewSize() {
        isTabelViewSmall.toggle()

        if isTabelViewSmall {
            if adressesArray.count == 0 {
                globalView.snp.remakeConstraints {
                    $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                    $0.top.equalToSuperview().offset(150)
                    $0.height.equalTo(96)
                }
            } else if adressesArray.count == 1 {
                globalView.snp.remakeConstraints {
                    $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                    $0.top.equalToSuperview().offset(150)
                    $0.height.equalTo(144)
                }
            } else if adressesArray.count == 2 {
                globalView.snp.remakeConstraints {
                    $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                    $0.top.equalToSuperview().offset(150)
                    $0.height.equalTo(192)
                }
            } else if adressesArray.count == 3 {
                globalView.snp.remakeConstraints {
                    $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                    $0.top.equalToSuperview().offset(150)
                    $0.height.equalTo(220)
                }
            }
            arrowImage.image = UIImage(named: "Caret left")
        } else {
            globalView.snp.remakeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                $0.top.equalToSuperview().offset(150)
                $0.height.equalTo(48)
            }
            arrowImage.image = UIImage(named: "down")
        }
    }
    
    @objc
    func pushViewController() {
        let viewContorller = SecondViewController()
        viewContorller.deleagte = self
        self.navigationController?.pushViewController(viewContorller, animated: true)
    }
}

extension DropDownViewController: PassTextProtocol {
    
    func passText(_ newAdress: String) {
        adressesArray.append(newAdress)
        dropTableView.reloadData()
    }
}
