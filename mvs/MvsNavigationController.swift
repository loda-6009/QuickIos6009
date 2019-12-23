//
//  MvsNavigationController.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 12. 23..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwiftConsumer

open class MvsNavigationController<S, I: RePageController<S>>: StateNavigationController<S>,
    IntentContainer {

    private(set) var isFirstLayout = true

    public private(set) var isAppeared = false

    public private(set) var intent: NSMutableDictionary = NSMutableDictionary()

    open func createInteractor() -> I? { return nil }

    convenience required public init() {
        self.init(nibName: nil, bundle: nil)
    }

    open override var pageController: RePageController<S>? {
        get {
            return super.pageController
        }
        set {
            if super.pageController != nil {
                super.pageController?.unbindState()
                print("기존 바인드 \(String(describing: super.pageController))삭제 -----in \(String(describing: self)) ")
            }
            super.pageController = newValue
            print("새 바인드 \(String(describing: newValue)) in \(String(describing: self)) ")
            super.pageController?.bindState()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        // 외부에서 주입된 경우, 새로 만들지 않는다.
        if pageController == nil {
            pageController = createInteractor()
            print("새로운 인스턴스 \(String(describing: pageController))  in \(String(describing: self))")
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAppeared = true
        bindConsumers()
        bindUIEvents()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        isAppeared = false
        unbindUIEvents()
        unbindConsumers()
        super.viewWillDisappear(animated)
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLayout {
            isFirstLayout = false
            firstDidLayout()
        }
    }

    /// once called at first layout time
    open func firstDidLayout() {
    }

    open func showLoading() {
        guard let child = children.last else {
            return
        }
        (child as? LoadingVisible)?.showLoading(child.view)
    }
    
    open func hideLoading() {
        if let child = children.last as? LoadingVisible {
            child.hideLoading()
        }
    }

    /// bind UI events
    /// called in viewWillAppear
    open func bindUIEvents() {}
    /// unbind UI events
    /// called in viewWillDisappear
    open func unbindUIEvents() {
    }
    /// bind Consumers
    /// called in viewWillAppear
    open func bindConsumers() {}
    
    /// bind Consumers
    /// called in viewWillDisappear
    open func unbindConsumers() {
        pageConsumer.removeAll()
    }
}
