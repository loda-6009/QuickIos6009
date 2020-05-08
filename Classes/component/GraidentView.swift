//
// Created by brownsoo han on 2018-12-26.
//

import UIKit

@IBDesignable
final public class GradientView: UIView {

    public convenience init() {
        self.init(frame: CGRect())
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onInit()
    }

    public override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            gradient?.frame = CGRect(x: 0, y: 0, width: newValue.width, height: newValue.height)
        }
    }
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.gradient?.cornerRadius = self.cornerRadius
        }
    }
    /// 0~360
    @IBInspectable
    public var gradientRotation: Float = 0 {
        didSet {
            let radian = gradientRotation / 180.0 * Float.pi
            self.gradient?.startPoint = CGPoint(
                x: CGFloat(cos(radian + Float.pi) * 0.5 + 0.5),
                y: CGFloat(sin(radian + Float.pi) * 0.5 + 0.5))
            self.gradient?.endPoint = CGPoint(
                x: CGFloat(cos(radian) * 0.5 + 0.5),
                y: CGFloat(sin(radian) * 0.5 + 0.5))
        }
    }

    /// gradient colors
    @IBInspectable
    public var gradientColors: [UIColor] = [UIColor(red: 178, green: 134, blue: 240).withAlphaComponent(0),
                                     UIColor(red: 178, green: 134, blue: 240).withAlphaComponent(0.7)] {
        didSet {
            gradient?.colors = gradientColors.map{ $0.cgColor }
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }

    private var gradient : CAGradientLayer? {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return nil }
        return gradientLayer
    }
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

    private func onInit() {
        gradient?.colors = gradientColors.map{ $0.cgColor }
        gradientRotation = 0
    }

    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient?.frame = self.frame
    }

}
