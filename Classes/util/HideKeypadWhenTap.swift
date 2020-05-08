//
//  HideKeyboardWhenTap.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 7. 26..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import UIKit

public protocol HideKeyboardWhenTapDelegate {
    /// Notify a view of UIViewController will be changes the frame
    ///
    /// - Parameters:
    ///   - to: changed view frame
    ///   - duration: keyboard animation time
    ///   - option: keyboard animation option
    ///   - visible: keyboard visible
    func willChangeViewFrame(_ to: CGRect,
                             duration: Double,
                             option: UIView.AnimationOptions,
                             visible: Bool)

    func shouldHideKeyboard(touchedView: UIView, touchPoint: CGPoint) -> Bool
}

public extension HideKeyboardWhenTapDelegate {
    func shouldHideKeyboard(touchedView: UIView, touchPoint: CGPoint) -> Bool {
        return true
    }
}

extension UIViewController {
    
    @discardableResult
    public func setupHideKeyboardWhenTapAround() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        // responsive keyboard frame
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillChange),
            name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
        return tap
        
    }

    @objc
    open func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        if let touchView = gestureRecognizer.view {
            //print("keyboard handleTap ----- \(touchView)")
            let point = gestureRecognizer.location(in: touchView)
            if let delegateHandling = (self as? HideKeyboardWhenTapDelegate)?.shouldHideKeyboard(touchedView: touchView, touchPoint: point),
               !delegateHandling {
                return
            }
            if touchView is UITextField {
                return
            }
            if touchView is UIControl {
                return
            }
        }
        view.endEditing(true)
    }
    
    @objc
    public func handleKeyboardWillChange(sender: Notification) {
        let n = KeyboardNotification(sender)
        let keyboardFrame = n.frameEndForView(view: self.view)
        let duration = n.animationDuration
        let curve = n.animationCurve
        var frame: CGRect = self.view.frame
        frame.size = CGSize(width: frame.size.width, height: keyboardFrame.minY)
        (self as? HideKeyboardWhenTapDelegate)?.willChangeViewFrame(frame, duration: duration,
                            option: UIView.AnimationOptions(rawValue: UInt(curve << 16)),
                            visible: frame.height < self.view.frame.height)
    }
}
