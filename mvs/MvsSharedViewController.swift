//
//  MvsSharedViewController.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 12. 23..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//
import Foundation
import ReSwift
import ReSwiftConsumer
import UIKit

@available(*, deprecated, message: "Use own custom VC")
open class MvsSharedViewController<SharedState: StateType & Equatable, I: RePageInteractor<SharedState>>
    : StateSharedViewController<SharedState>,
    LoadingVisible, IntentContainer {

    private(set) var isFirstLayout = true

    public lazy var loadingView = LoadingView()

    public private(set) var intent: NSMutableDictionary = NSMutableDictionary()

    public var sharedInteractor: I? = nil

    public let pageConsumer = StateConsumer<SharedState>()

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sharedInteractor?.addSharedConsumer(pageConsumer)
        bindUIEvents()
        bindConsumers()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sharedInteractor?.removeSharedConsumer(pageConsumer)
        unbindUIEvents()
        unbindConsumers()
    }

    deinit {
        sharedInteractor = nil
    }

    override open func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewDidDisappear(animated)
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
    open func bindConsumers() {
    }
    
    /// bind Consumers
    /// called in viewWillDisappear
    open func unbindConsumers() {
        pageConsumer.removeAll()
    }
}

extension MvsSharedViewController: AlertPop {
    public func alertPop(_ title: String?,
                         message: String,
                         positive: String? = nil,
                         positiveCallback: ((_ action: UIAlertAction)->Void)? = nil,
                         alt: String? = nil,
                         altCallback: ((_ action: UIAlertAction) -> Void)? = nil) {
        
        alertPop(self,
                 title: title,
                 message: message,
                 positive: positive,
                 positiveCallback: positiveCallback,
                 alt: alt,
                 altCallback: altCallback)
    }
}
