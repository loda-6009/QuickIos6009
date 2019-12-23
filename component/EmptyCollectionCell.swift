//
//  EmptyCollectionCell.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 2. 20..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import UIKit

public class EmptyCollectionCell: UICollectionViewCell {
    
    public static let identifier = "EmptyCell".toAppIdentifier()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onInit()
    }
    
    private func onInit() {
    }
}
