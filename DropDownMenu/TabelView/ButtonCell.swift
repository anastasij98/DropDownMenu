//
//  ButtonCell.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 11.10.23.
//

import Foundation
import UIKit
import SnapKit

struct ButtonCellModel {
    
//    var deleagte: PushViewControllerProtocol?
}

class ButtonCell: UITableViewCell {
    
//    weak var delegate : PushViewControllerProtocol?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Добавить"
        label.textColor = UIColor(red: 0.329,
                                          green: 0.557,
                                          blue: 1,
                                          alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .bold)
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет добавленных адресов"
        label.textColor = UIColor(red: 0.677,
                                        green: 0.732,
                                        blue: 0.804,
                                        alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
    
        return label
    }()

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

//        if highlighted == true {
//            self.contentView.backgroundColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
//        } else {
//            self.contentView.backgroundColor = .clear
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if selected == true {
//            self.contentView.backgroundColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
//        } else {
//            self.contentView.backgroundColor = .clear
//        }
    }
    
    func setupCell(model: ButtonCellModel,
                   count: Int) {
//        delegate = model.deleagte
        self.addSubview(label)
        self.addSubview(adressLabel)

        if count > 0 {
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            adressLabel.isHidden = true
        } else {
            label.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            
            adressLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            adressLabel.isHidden = false
        }
    }
}
