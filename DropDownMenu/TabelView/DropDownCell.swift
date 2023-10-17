//
//  TabelViewCell.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 05.09.23.
//

import Foundation
import UIKit

class DropDownCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted == true {
            self.contentView.backgroundColor = UIColor(red: 0.894, green: 0.937, blue: 0.988, alpha: 1)
        } else {
            self.contentView.backgroundColor = .white
        }
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
