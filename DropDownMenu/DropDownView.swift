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
        label.textColor = .mainTextGrayColor
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
    
    var dataSource: [String] = []

    var isTabelViewSmall = true
    var isAdressSelected = true
    
    fileprivate var didSelectCompletion: (String, Int) -> Void = { _, _ in }
    fileprivate var didSelectLastCellCompletion: () -> Void = { }
    
    init(_ dataSource: [String] = []) {
        super.init(frame: .init())

        self.dataSource = dataSource
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
        var height = dataSource.count == 0 ? 96 : ((dataSource.count + 2) * 48)
        height = height > 212 ? 212 : height
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self.layoutSubviews()
        })
        globalView.layer.borderColor = .mainBlue
        smallLabel.textColor = .mainBlue
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
        globalView.layer.borderColor = .gray
        smallLabel.textColor = .gray
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
    
    func changeColorNewAdress() {
        globalView.layer.borderColor = UIColor(red: 0.677,
                                               green: 0.732,
                                               blue: 0.804,
                                               alpha: 1).cgColor
        smallLabel.textColor = UIColor(red: 0.68,
                                       green: 0.73,
                                       blue: 0.8,
                                       alpha: 1)
        smallLabel.isHidden = false
        adressLabel.textColor = (adressLabel.text?.contains("Адрес доставки") ?? false) ? .lightGray : .black
    }
    
    func changeHeaderTitle(_ indexPath: Int) {
        adressLabel.text = dataSource[indexPath]
        adressLabel.textColor = (adressLabel.text?.contains("Адрес доставки") ?? false) ? .lightGray : .black
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

extension DropDownView {
    
    // MARK: Actions Methods
    
    public func didSelect(completion: @escaping (_ selectedText: String, _ index: Int) -> Void) {
        didSelectCompletion = completion
    }
    
    public func didSelectLastCell(_ viewController: UIViewController, _ secondViewController: UIViewController, completion: @escaping () -> Void) {
        didSelectLastCellCompletion = completion
    }
    
    public func newAdress(_ newAdress: String) {
        adressLabel.text = newAdress
        dataSource.append(newAdress)
        changeColorNewAdress()
        tableView.reloadData()
    }
}

extension DropDownView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let intIndexPath = indexPath.row
        if intIndexPath != dataSource.count  {
            changeHeaderTitle(intIndexPath)
            let selectedText = dataSource[intIndexPath]
            didSelectCompletion(selectedText, intIndexPath)
        } else {
            didSelectLastCellCompletion()
        }
        changeTableViewSize()
    }
}

extension DropDownView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != dataSource.count && dataSource.count > 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.reuseIdentifier,
                                                     for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier) as? ButtonCell else {
                return UITableViewCell()
            }
            cell.setupCell(count: dataSource.count)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
