//
//  ViewController.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 24.08.23.
//

import UIKit
import SnapKit

class DropDownViewController: UIViewController {
    
    var dropTableView = UITableView()
    let adressesArray = ["ул. Большая Садовая",
                         "пр. Кировский",
                         "пр. Ворошиловский",
                         "ул. Зорге",
                         "ул. Извилистая",
                         "пл. Ленина",
                         "бул. Комарова",
                         "пр. Королёва"]
//    var adressesArray: Array<String> = .init()

    let headerView = DropDownHeader()
    var hideTableView = false

//    lazy var button: UIButton = {
//        let button = UIButton()
//        button.setTitle("Добавить", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(addAdress), for: .touchUpInside)
//        return button
//    }()
    
    let smallLabel = UILabel()
    
//    let customHeader = UIView(frame: CGRect(x: 0,
//                                            y: 0,
//                                            width: 200,
//                                            height: 48))
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabelView()
        view.addSubview(smallLabel)

        smallLabel.text = "Адрес доставки"
        smallLabel.font = UIFont.systemFont(ofSize: 12)
        smallLabel.textColor = UIColor(red: 0.329, green: 0.557, blue: 1, alpha: 1)
        smallLabel.backgroundColor = .white
        smallLabel.isHidden = true
        smallLabel.snp.makeConstraints({
            $0.bottom.equalTo(dropTableView.snp.top).inset(9)
            $0.leading.equalTo(dropTableView.snp.leading).inset(20)
            $0.height.equalTo(18)
            $0.width.equalTo(95)
        })
    }

    func setupTabelView() {
        view.addSubview(dropTableView)
        
        dropTableView.delegate = self
        dropTableView.dataSource = self
        dropTableView.tintColor = .black
        dropTableView.separatorStyle = .none
        
        dropTableView.contentInsetAdjustmentBehavior = .never
        dropTableView.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.reuseIdentifier)
        dropTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        dropTableView.register(DropDownHeader.self, forHeaderFooterViewReuseIdentifier: DropDownHeader.reuseIdentifier)
        dropTableView.isScrollEnabled = false
        dropTableView.layer.cornerRadius = 20
        dropTableView.layer.borderColor = UIColor(red: 0.329, green: 0.557, blue: 1, alpha: 1).cgColor
        dropTableView.layer.borderWidth = 1
        //        dropTableView.tableHeaderView = headerTabelView()
        dropTableView.sectionFooterHeight = 20
        dropTableView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
            $0.height.equalTo(48)
        }

        
        
        if #available(iOS 15, *) {
            print("This code only runs on iOS 15 and up")
            dropTableView.sectionHeaderTopPadding = 0
        } else {
            print("This code only runs on iOS 14 and lower")
        }
    }
    
    @objc
    func hideTabelViewsCell() {
        changeTableViewSize()
    }
    
//    @objc
//    func addAdress(_ adress: String) {
//        dropTableView.reloadData()
//    }
//
//    func addAdressToArray(_ adress: String) {
//        adressesArray.append(adress)
//    }
    
    func changeHeaderTitle(_ indexPath: Int) {
        headerView.label.text = adressesArray[indexPath]
        headerView.label.textColor = .black
    }
    
    func changeTableViewSize() {      
        hideTableView.toggle()
        
        if hideTableView {
            dropTableView.isScrollEnabled = true
            dropTableView.snp.remakeConstraints {            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                $0.top.equalToSuperview().offset(150)
                $0.height.equalTo(240)
            }
            dropTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            dropTableView.isScrollEnabled = false
            dropTableView.snp.remakeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview().inset(16)
                $0.top.equalToSuperview().offset(150)
                //                $0.height.equalTo(headerView.snp.height)
                $0.height.equalTo(48)
            }
        }
    }
    
    private func headerTabelView() -> UIView {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.dropTableView.frame.width,
                                        height: 50))
        view.backgroundColor = .green
        return view
    }
}

extension DropDownViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeHeaderTitle(indexPath.row)
        smallLabel.isHidden = false
//        headerView.bringSubviewToFront(headerView.smallLabel)
        changeTableViewSize()
        dropTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        dropTableView.scrollToRow(at: indexPath, at: .top, animated: true)

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.hideTabelViewsCell))

        headerView.addGestureRecognizer(tap)
//        headerView.tintColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
        headerView.tintColor = .white
        headerView.setupPlaceholder()
        headerView.layoutSubviews()
        return headerView
    }
}

extension DropDownViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adressesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropTableView.dequeueReusableCell(withIdentifier: DropDownCell.reuseIdentifier,
                                                     for: indexPath)
        
        cell.textLabel?.text = adressesArray[indexPath.row]
        cell.selectionStyle = .none
//        dropTableView.isScrollEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
}


class DropDownCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
        
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//
//        if highlighted == true {
//            self.contentView.backgroundColor = .blue.withAlphaComponent(0.1)
//        } else {
//            self.contentView.backgroundColor = .white
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {
            self.contentView.backgroundColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
        } else {
            self.contentView.backgroundColor = .white
        }
    }
}
