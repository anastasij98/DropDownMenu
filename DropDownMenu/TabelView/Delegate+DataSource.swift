//
//  Delegate+DataSource.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 05.09.23.
//

import Foundation
import UIKit

extension DropDownViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalView.layer.borderColor = UIColor(red: 0.329,
                                               green: 0.557,
                                               blue: 1,
                                               alpha: 1).cgColor
        errorLabel.isHidden = true
        if indexPath.row != adressesArray.count  {
            changeHeaderTitle(indexPath.row)
            smallLabel.isHidden = false
            changeTableViewSize()
        } else {
            pushViewController()
        }
    }
}

extension DropDownViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adressesArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row != adressesArray.count  {
            let cell = dropTableView.dequeueReusableCell(withIdentifier: DropDownCell.reuseIdentifier,
                                                         for: indexPath)
            cell.textLabel?.text = adressesArray[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = dropTableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier) as? ButtonCell else {
                return UITableViewCell()
            }
            let model = ButtonCellModel(deleagte: self)
            cell.setupCell(model: model,
                           count: adressesArray.count)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            adressesArray.remove(at: indexPath.row )
            dropTableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}


