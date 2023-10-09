//
//  TabelViewCell.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 05.09.23.
//

import Foundation
import UIKit
import SnapKit

class DropDownCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            self.contentView.backgroundColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
        } else {
            self.contentView.backgroundColor = .white
        }
    }
}

struct ButtonCellModel {
    
    var deleagte: CustomCellDelegate?
}

class ButtonCell: UITableViewCell {
    
    weak var delegate : CustomCellDelegate?
    
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
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            backgroundColor = .white
        }
    }
    
    func setupCell(model: ButtonCellModel,
                   count: Int) {
        delegate = model.deleagte
        self.addSubview(label)
        
        if count > 0 {
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
        } else {
            self.addSubview(adressLabel)

            label.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            
            adressLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
        }
    }
}
