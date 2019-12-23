//
//  BaseViewController.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 26/12/2018.
//

import Foundation

open class BaseViewController: UIViewController, ForegroundNotable, IntentContainer, LoadingVisible {

    private(set) var isFirstLayout = true

    private(set) public var isAppeared = false

    public private(set) var intent: NSMutableDictionary = NSMutableDictionary()

    override open func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = UIColor.white
        }
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAppeared = true
        bindUIEvents()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        isAppeared = false
        unbindUIEvents()
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
    open func didBackground() {
    }
    open func didForeground() {
    }
    /// bind UI events
    /// called in viewWillAppear
    open func bindUIEvents() {}
    /// unbind UI events
    /// called in viewWillDisappear
    open func unbindUIEvents() {
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


extension BaseViewController: AlertPop {
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
