//
//  HeaderView.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 24.08.23.
//

import Foundation
import UIKit

class DropDownHeader: UITableViewHeaderFooterView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    let label = UILabel()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "downArrow")
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPlaceholder() {
        self.addSubview(label)
        self.addSubview(imageView)
        
        label.snp.makeConstraints({
//            $0.edges.equalTo(self.snp.edges)
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
            $0.leading.equalTo(self.snp.leading)
        })
        
        imageView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
            $0.trailing.equalTo(self.snp.trailing)
            $0.width.equalTo(34)

        }
        label.text = "Адрес доставки"
        label.textColor = UIColor(red: 0.677, green: 0.732, blue: 0.804, alpha: 1)
    }
    
    func chahgeArrow(_ needUpArrow: Bool) {
        if needUpArrow {
            imageView.image = UIImage(named: "up")
        } else {
            imageView.image = UIImage(named: "downArrow")
        }
    }
}
