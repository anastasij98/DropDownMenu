//
//  UITabelViewCell.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 22.01.24.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
