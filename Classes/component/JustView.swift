//
//  JustView.swift
//
import UIKit

@IBDesignable
open class JustView: UIView {
    public convenience init() {
        self.init(frame: CGRect())
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        onInit()
    }

    open func onInit() {
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            if let previous = previousTraitCollection {
                if self.traitCollection.userInterfaceStyle != previous.userInterfaceStyle {
                    (self as? UIStyleChanges)?.didUIStyleChanged(to: self.traitCollection.userInterfaceStyle)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

open class JustButton: UIButton {
    public convenience init() {
        self.init(type: .custom)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        onInit()
    }
    
    open func onInit() {
    }
}


public extension JustView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
