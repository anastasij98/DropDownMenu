//
//  DropDownView.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 23.10.23.
//

import Foundation
import SnapKit

class DropDownView: UIView {
    
    lazy var globalView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
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

    lazy var tableView: UITableView = {
        let tableView = DynamicSizeTabelView(maxHeight: 164)
        tableView.tintColor = .black
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.textColor = UIColor(red: 0.958,
                                  green: 0.504,
                                  blue: 0.475,
                                  alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    
    var adressesArray: [String] = [""]

    var isTabelViewSmall = true
    var isAdressSelected = true
    
    fileprivate var didSelectCompletion: (String, Int) -> Void = { _, _ in }
    fileprivate var didSelectLastCellCompletion: () -> Void = { }
    
    init(adressesArray: [String] = [""]) {
        super.init(frame: .init())

        self.adressesArray = adressesArray
        self.addViews()
        self.setupLayouts()
        self.bindViews()
        self.changeColor()
        self.setupTabelView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(globalView)
        self.addSubview(smallLabel)
        self.addSubview(errorLabel)
        globalView.addSubview(adressLabel)
        globalView.addSubview(tableView)
        adressLabel.addSubview(arrowImage)
    }
    
    func setupLayouts() {
        globalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        adressLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            $0.top.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        smallLabel.snp.makeConstraints {
            $0.bottom.equalTo(adressLabel.snp.top).inset(9)
            $0.leading.equalTo(globalView.snp.leading).inset(20)
            $0.height.equalTo(18)
            $0.width.equalTo(95)
        }

        tableView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(adressLabel.snp.bottom)
            $0.bottom.equalTo(globalView.snp.bottom)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(globalView.snp.bottom).inset(15)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().inset(36)
        }
    }
    
    func bindViews() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(changeTableViewSize))
        adressLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupTabelView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(DropDownCell.self,
                           forCellReuseIdentifier: DropDownCell.reuseIdentifier)
        tableView.register(ButtonCell.self,
                           forCellReuseIdentifier: ButtonCell.reuseIdentifier)
    }
    
    //MARK: -
    
    @objc
    func gestureForAdressLabel() {
        changeColor()
    }
    
    //MARK: - Change tabelView size
    @objc
    func changeTableViewSize() {
        changeColor()
        isTabelViewSmall ? showTabelView() : hideTabelView()
        isTabelViewSmall.toggle()
    }

    func showTabelView() {
        let height = adressesArray.count == 0 ? 48 : ((adressesArray.count + 1) * 48)
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self.layoutSubviews()
        })
        globalView.layer.borderColor = .mainBlue
        smallLabel.textColor = UIColor(red: 0.329,
                                       green: 0.557,
                                       blue: 1,
                                       alpha: 1)
        self.arrowImage.image = UIImage(named: "up")
    }
    
    func hideTabelView() {
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.snp.updateConstraints {
                $0.height.equalTo(48)
            }
            self.layoutSubviews()
        })
        globalView.backgroundColor = .white
        globalView.layer.borderColor = UIColor(red: 0.677, green: 0.732, blue: 0.804, alpha: 1).cgColor
        smallLabel.textColor = UIColor(red: 0.68,
                                       green: 0.73,
                                       blue: 0.8,
                                       alpha: 1)
        self.arrowImage.image = UIImage(named: "down")
    }
    
    //MARK: -

    func changeColor() {
        isAdressSelected.toggle()
        if let text = adressLabel.text,
           text.contains("Адрес доставки") && !isAdressSelected {
            globalView.backgroundColor = .lightGray
            globalView.layer.borderColor = .white
            smallLabel.isHidden = true
        } else {
            globalView.backgroundColor = .white
            globalView.layer.borderColor = .mainBlue
            smallLabel.isHidden = false
        }
    }
    
    func changeHeaderTitle(_ indexPath: Int) {
        adressLabel.text = adressesArray[indexPath]
        adressLabel.textColor = .black
    }

    func changeState() {
        if let text = adressLabel.text,
           text.contains("Адрес доставки") {
            globalView.layer.borderColor = .red
            errorLabel.isHidden = false
        } else {
            globalView.layer.borderColor = .mainBlue
            errorLabel.isHidden = true
        }
    }
}

extension DropDownView: PassTextProtocol {

    func passText(_ newAdress: String) {
//        adressLabel.text = newAdress
    }
}

extension DropDownView {
    
    // MARK: Actions Methods
    
    public func didSelect(completion: @escaping (_ selectedText: String, _ index: Int) -> Void) {
        didSelectCompletion = completion
    }
    
    public func didSelectLastCell(completion: @escaping () -> Void) {
        didSelectLastCellCompletion = completion
    }
}

extension DropDownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        globalView.layer.borderColor = UIColor(red: 0.329,
        //                                               green: 0.557,
        //                                               blue: 1,
        //                                               alpha: 1).cgColor
        //        errorLabel.isHidden = true
        let intIndexPath = indexPath.row
        if intIndexPath != adressesArray.count  {
            changeHeaderTitle(intIndexPath)
            //            smallLabel.isHidden = false
            changeTableViewSize()
            
            let selectedText = adressesArray[intIndexPath]
            didSelectCompletion(selectedText, intIndexPath)
        } else {
            ////            pushViewController()
            didSelectLastCellCompletion()
            print(">>> didSelectRowAt")
        }
    }
}

extension DropDownView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adressesArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != adressesArray.count && adressesArray.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.reuseIdentifier,
                                                     for: indexPath)
            cell.textLabel?.text = adressesArray[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier) as? ButtonCell else {
                return UITableViewCell()
            }
            cell.setupCell(model: ButtonCellModel(),
                           count: adressesArray.count)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            adressesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
