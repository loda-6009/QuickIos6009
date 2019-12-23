//
//  TouchEffectView.swift
//

@IBDesignable
open class TouchEffectView: UIControl {

    public var isTouchEffect: Bool = true

    public lazy var effectLayer: CAShapeLayer = {
        let effect = CAShapeLayer()
        effect.fillColor = nil
        return effect
    }()

    public var defaultHighlightColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue.withAlphaComponent(0.05)
        }
        return UIColor.blue.withAlphaComponent(0.05)
    }

    public var highlightColor: UIColor = UIColor.blue.withAlphaComponent(0.05) {
        didSet {
            effectLayer.fillColor = self.highlightColor.cgColor
        }
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
        layer.insertSublayer(effectLayer, at: 0)
        highlightColor = defaultHighlightColor
    }

    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isTouchEffect {
            touchEffect()
        }
        return super.beginTracking(touch, with: event)
    }

    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if isTouchEffect {
            clearTouchEffect()
        }
    }

    open override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        if isTouchEffect {
            clearTouchEffect()
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isTouchEffect {
            touchEffect()
        }
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isTouchEffect {
            clearTouchEffect()
        }
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if isTouchEffect {
            clearTouchEffect()
        }
    }

    private func fitOutline() {
        effectLayer.frame = self.bounds
        effectLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
    }

    private func touchEffect() {
        let color = self.highlightColor.cgColor
        fitOutline()
        DispatchQueue.main.async { [weak self] in
            self?.effectLayer.fillColor = color
        }
    }

    private func clearTouchEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.effectLayer.fillColor = nil
        }
    }
}
