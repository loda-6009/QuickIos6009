//
//  UIStyleChanges.swift
//  QuickSupport
//
//  Created by brownsoo han on 2019/09/30.
//  Copyright © 2019 6009. All rights reserved.
//

import Foundation

public protocol UIStyleChanges {
    @available(iOS 12.0, *)
    func didUIStyleChanged(to style: UIUserInterfaceStyle) -> Void
}

public extension UIStyleChanges {
    @available(iOS 12.0, *)
    func didUIStyleChanged(to style: UIUserInterfaceStyle) -> Void {}
}
