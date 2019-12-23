//
//  BaseTableCell.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 6. 18..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import UIKit

open class JustTableCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func onInit() {
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            if let previous = previousTraitCollection {
                if self.traitCollection.userInterfaceStyle != previous.userInterfaceStyle {
                    (self as? UIStyleChanges)?.didUIStyleChanged(to: self.traitCollection.userInterfaceStyle)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}

