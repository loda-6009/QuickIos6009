//
//  RunOnMain.swift
//  QuickSupport
//
//  Created by brownsoo han on 07/08/2019.
//  Copyright © 2019 6009. All rights reserved.
//

import Foundation

public protocol RunOnMain {
    /// DispatchQueue.main.async 으로 전달
    func runOnMain(_ block:@escaping ()->Void)
    /// DispatchQueue.main.asyncAfter 로 전달
    func runOnMain(_ block:@escaping ()->Void, delay: TimeInterval)
}

public extension RunOnMain {

    func runOnMain(_ block:@escaping ()->Void) {
        self.runOnMain(block, delay: 0)
    }

    func runOnMain(_ block:@escaping ()->Void, delay: TimeInterval) {
        if delay > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                block()
            }
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
