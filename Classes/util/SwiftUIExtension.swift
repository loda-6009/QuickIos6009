//
//  SwiftUIExtension.swift
//  QuickSupport
//
//  Created by hyonsoo han on 2020/04/01.
//  Copyright © 2020 6009. All rights reserved.
//

import SwiftUI

/// Inline wrapping of UIKit or AppKit views within SwiftUI
/// https://www.swiftbysundell.com/tips/inline-wrapping-of-uikit-or-appkit-views-within-swiftui/

@available(iOS 13.0, *)
struct Wrap<Wrapped: UIView>: UIViewRepresentable {
    typealias Updater = (Wrapped, Context) ->Void
    
    var makeView: () -> Wrapped
    var update: Updater
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping Updater) {
        self.makeView = makeView
        self.update = update
    }
    
    func makeUIView(context: Context) -> Wrapped {
        makeView()
    }
    
    func updateUIView(_ view: Wrapped, context: Context) {
        update(view, context)
    }
}

@available(iOS 13.0, *)
extension Wrap {
    // makes optional Context
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping (Wrapped) -> Void) {
        self.makeView = makeView
        self.update = { view, _ in update(view) }
    }
    // makes optional updater
    init(_ makeView: @escaping @autoclosure () -> Wrapped) {
        self.makeView = makeView
        self.update = { _, _ in }
    }
}

