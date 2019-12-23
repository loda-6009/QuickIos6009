//
//  LoadingVisible.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 11. 2..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import UIKit

public protocol LoadingVisible {
    var loadingView: LoadingView { get }
    func showLoading(_ container: UIView)
    func showLoading(_ container: UIView, text: String?)
    func showLoading(_ container: UIView, text: String?, fullscreen:Bool)
    func hideLoading()
}

public extension LoadingVisible {
    
    func showLoading(_ container: UIView) {
        self.showLoading(container, text: "Loading...", fullscreen: false)
    }

    func showLoading(_ container: UIView, text: String?) {
        self.showLoading(container, text: text, fullscreen: false)
    }
}

/// LoadingVisible extension 구현
public protocol LoadingVisibleDone : LoadingVisible {
}

public extension LoadingVisibleDone where Self: UIViewController {

    func showLoading(_ container: UIView, text: String?, fullscreen:Bool) {

        DispatchQueue.main.async { [unowned self] in
            self.loadingView.text = text
            self.loadingView.loading = true
            if #available(iOS 13, *), container.traitCollection.userInterfaceStyle == .dark {
                self.loadingView.boxColor = UIColor.secondarySystemBackground
                self.loadingView.indicatorColor = UIColor.label
            }

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

    func hideLoading() {
        if self.loadingView.superview == nil {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeFromSuperview()
        }
    }
}
