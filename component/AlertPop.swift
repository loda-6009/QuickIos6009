//
//  AlertPop.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 5. 29..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import UIKit

public class QuickAlertController: UIAlertController {}

public protocol AlertPop {

    func alertPop(_ title: String?, message: String)

    func alertPop(_ title: String?,
                  message: String,
                  positive: String?,
                  positiveCallback: ((_ action: UIAlertAction)->Void)?)

    func alertPop(_ title: String?,
                  message: String,
                  positive: String?,
                  positiveCallback: ((_ action: UIAlertAction)->Void)?,
                  alt: String?,
                  altCallback: ((_ action: UIAlertAction)->Void)?)
    /// Alert helper
    func alertPop(_ parent: UIViewController,
                  title: String?,
                  message: String,
                  positive: String?,
                  positiveCallback: ((_ action: UIAlertAction)->Void)?,
                  alt: String?,
                  altCallback: ((_ action: UIAlertAction)->Void)?)
}

public extension AlertPop where Self: UIViewController {
    func alertPop(_ title: String?, message: String) {
        alertPop(self, title: title, message: message, positive: nil, positiveCallback: nil, alt: nil, altCallback: nil)
    }

    func alertPop(_ title: String?,
                  message: String,
                  positive: String?,
                  positiveCallback: ((_ action: UIAlertAction)->Void)?) {
        alertPop(self, title: title, message: message, positive: positive, positiveCallback: positiveCallback, alt: nil, altCallback: nil)
    }

    func alertPop(_ title: String?,
                  message: String,
                  positive: String?,
                  positiveCallback: ((_ action: UIAlertAction)->Void)?,
                  alt: String?,
                  altCallback: ((_ action: UIAlertAction)->Void)?) {
        alertPop(self, title: title, message: message, positive: positive, positiveCallback: positiveCallback, alt: alt, altCallback: altCallback)
    }
    func alertPop(_ parent: UIViewController,
                         title: String?,
                         message: String,
                         positive: String? = nil,
                         positiveCallback: ((_ action: UIAlertAction)->Void)? = nil,
                         alt: String? = nil,
                         altCallback: ((_ action: UIAlertAction) -> Void)? = nil) {
        
        let alert = QuickAlertController(title: title, message: message, preferredStyle: .alert)
        if let alt = alt {
            let altAction = UIAlertAction(title: alt, style: .default, handler: altCallback)
            alert.addAction(altAction)
        }
        let okAction = UIAlertAction(title: positive ?? "닫기", style: .default, handler: positiveCallback)
        alert.addAction(okAction)
        if let presented = parent.presentedViewController as? QuickAlertController {
            presented.dismiss(animated: false, completion: {
                parent.present(alert, animated: true)
            })
        } else {
            parent.present(alert, animated: true)
        }
    }
}
