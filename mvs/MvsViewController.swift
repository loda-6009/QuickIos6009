//
//  MvsViewController.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwiftConsumer
import ReSwift

open class MvsViewController<S: StateType & Equatable, I: RePageController<S>>
    : StateViewController<S>, IntentContainer, LoadingVisible {

    private(set) var isFirstLayout = true

    public private(set) var isAppeared = false

    public private(set) var intent: NSMutableDictionary = NSMutableDictionary()

    open func createInteractor() -> I { return I() }

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

    override open func viewDidLoad() {
        super.viewDidLoad()
        if pageController == nil {
            self.pageController = createInteractor()
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
    
    /// unbind Consumers
    /// called in viewWillDisappear
    open func unbindConsumers() {
        // FIXME: 위로 올릴까?
        pageConsumer.removeAll()
    }


    // LoadingVisible

    open var loadingView = LoadingView()

    open func showLoading(_ container: UIView, text: String?, fullscreen:Bool) {
        DispatchQueue.main.async {
            self.loadingView.text = text
            self.loadingView.loading = true

            if fullscreen == true,
                let window = UIApplication.shared.keyWindow {
                self.loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                self.loadingView.isUserInteractionEnabled = true
                self.loadingView.frame = window.bounds
                window.addSubview(self.loadingView)
            } else {
                self.loadingView.backgroundColor = UIColor.clear
                self.loadingView.isUserInteractionEnabled = false
                self.loadingView.frame = container.bounds
                container.addSubview(self.loadingView)
            }
        }
    }

    open func hideLoading() {
        if self.loadingView.superview == nil {
            return
        }
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
        }
    }
}

