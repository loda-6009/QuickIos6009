import UIKit

@IBDesignable
open class QuickButton: UIButton {

    public convenience init() {
        self.init(type: .custom)
        onInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var defaultNormalColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        }
        return UIColor.white
    }
    var defaultHighlightColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground
        }
        return UIColor.black.brightness(brightness: 0.5)
    }
    var defaultDisableColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground.brightness(brightness: 0.7)
        }
        return UIColor.black.brightness(brightness: 0.9)
    }
    var defaultBorderColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray4
        }
        return UIColor.lightGray
    }

    @IBInspectable
    public var normalColor: UIColor = UIColor.white

    @IBInspectable
    public var highlightColor: UIColor = UIColor.black.brightness(brightness: 0.5)

    @IBInspectable
    public var disableColor: UIColor = UIColor.black.brightness(brightness: 0.9)

    @IBInspectable
    public var borderColor: UIColor = UIColor.lightGray

    @IBInspectable
    public var borderWidth: CGFloat = 1

    @IBInspectable
    public var icon: UIImage? = nil {
        didSet {
            iconIv.image = icon
        }
    }

    private static let defaultGradientColors = [UIColor(red: 255, green: 111, blue: 97),
                                                UIColor(red: 211, green: 80, blue: 145)]

    private let pi = CGFloat(Float.pi)

    private var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = defaultGradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()

    @IBInspectable
    public var gradientColors: [UIColor] = defaultGradientColors {
        didSet {
            gradientLayer.colors = gradientColors.map{ $0.cgColor }
        }
    }

    /// Center position for gradientRotation
    @IBInspectable
    public var gradientRotationCenter: CGPoint = CGPoint(x: 0.5, y: 0.5)

    /// Rotate gradient in degree
    /// It changes startPoint and endPoint of gradient layer
    public func gradientRotate(degree: CGFloat) {
        let radian = degree / 180.0 * pi
        let startX = gradientRotationCenter.x
        let startY = gradientRotationCenter.y
        self.gradientStartPoint = CGPoint(
            x: CGFloat(cos(radian + pi) * startX + 0.5),
            y: CGFloat(sin(radian + pi) * startY + 0.5))
        let endX = 1 - gradientRotationCenter.x
        let endY = 1 - gradientRotationCenter.y
        self.gradientEndPoint = CGPoint(
            x: CGFloat(cos(radian) * endX + 0.5),
            y: CGFloat(sin(radian) * endY + 0.5))
    }

    @IBInspectable
    public var gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet {
            self.gradientLayer.startPoint = gradientStartPoint
        }
    }

    @IBInspectable
    public var gradientEndPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            self.gradientLayer.endPoint = gradientEndPoint
        }
    }

    // private var size = CGSize()
    private lazy var iconIv = UIImageView()
    private lazy var _shadowLayer: CAShapeLayer = {
        let shadow = CAShapeLayer()
        shadow.fillColor = UIColor.clear.cgColor
        shadow.shadowColor = UIColor.black.cgColor
        shadow.shadowOpacity = 0.1
        shadow.shadowRadius = 8
        shadow.shadowOffset = CGSize(width: 0, height: 4)
        return shadow
    }()

    open var shadowLayer: CAShapeLayer {
        return _shadowLayer
    }

    private var _size = CGSize.zero

    @IBInspectable
    public var shadowing: Bool = true {
        didSet {
            _size = CGSize.zero
            updateState()
        }
    }

    @IBInspectable
    public var useGradient: Bool = false {
        didSet {
            _size = CGSize.zero
            updateState()
        }
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 8 {
        didSet {
            _size = CGSize.zero
            updateState()
        }
    }

    open override var isEnabled: Bool {
        set {
            super.isEnabled = newValue
            updateState()
        }
        get {
            return super.isEnabled
        }
    }

    private func updateState() {

        let bw = bounds.width
        let bh = bounds.height
        let r = cornerRadius

        if _size != bounds.size {
            _size = bounds.size
            if !useGradient {
                setBackgroundImage(UIImage().solid(normalColor, width: bw, height: bh).round(r), for: .normal)
            }
            setBackgroundImage(UIImage().solid(highlightColor, width: bw, height: bh).round(r), for: .highlighted)
            setBackgroundImage(UIImage().solid(disableColor, width: bw, height: bh).round(r), for: .disabled)
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
            shadowLayer.shadowPath = UIBezierPath(
                roundedRect: CGRect(x: 9, y: 0, width: bw - 18, height: bh),
                cornerRadius: r).cgPath
        }

        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = r

        layer.cornerRadius = r

        if isEnabled {
            if useGradient {
                layer.insertSublayer(gradientLayer, at: 0)
            } else {
                gradientLayer.removeFromSuperlayer()
            }
            if shadowing {
                layer.insertSublayer(shadowLayer, at: useGradient ? 1 : 0)
            } else {
                shadowLayer.removeFromSuperlayer()
            }
        } else {
            gradientLayer.removeFromSuperlayer()
            shadowLayer.removeFromSuperlayer()
        }

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = isEnabled ? borderWidth : 0
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        onInit()
    }

    open override func prepareForInterfaceBuilder() {
        //super.prepareForInterfaceBuilder()
        onInit()
    }

    open func onInit() {
        addSubview(iconIv)
        iconIv.translatesAutoresizingMaskIntoConstraints = false
        iconIv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconIv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconIv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        iconIv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        normalColor = defaultNormalColor
        highlightColor = defaultHighlightColor
        disableColor = defaultDisableColor
        borderColor = defaultBorderColor
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        updateState()
    }
}
