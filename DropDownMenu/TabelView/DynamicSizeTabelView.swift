//
//  DynamicSizeTabelView.swift
//  DropDownMenu
//
//  Created by LUNNOPARK on 11.10.23.
//

import Foundation
import UIKit

class DynamicSizeTabelView: UITableView {
    
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    var minHeight: CGFloat
    var minWidth: CGFloat
    
    override var intrinsicContentSize: CGSize {
        var height = min(max(contentSize.height, minHeight), maxHeight)
        height = height > maxHeight ? maxHeight : height
        var width = min(max(contentSize.width, minWidth), maxWidth)
        width = width > maxWidth ? maxWidth : width
        return CGSize(width: width, height: height)
    }
    
    init(frame: CGRect = .zero,
         collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout(),
         maxHeight: CGFloat = UIScreen.main.bounds.size.height,
         maxWidth: CGFloat = UIScreen.main.bounds.size.width,
         minHeight: CGFloat = 0,
         minWidth: CGFloat = 0) {
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.minWidth = minWidth
        
        super.init(frame: frame, style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !__CGSizeEqualToSize(bounds.size,
                                self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
}
