//
//  LoadingView.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 11. 29..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import UIKit

open class LoadingView: UIView {
    
    lazy var box = UIView()
    lazy var indicator = UIActivityIndicatorView(style: .whiteLarge)
    lazy var label = UILabel()
    
    open var loading: Bool {
        get {
            return indicator.isAnimating
        }
        
        set {
            if newValue {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
        }
    }

    open var text: String? = nil {
        didSet {
            label.text = text
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 400)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private let defaultIndicatorColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.label
        }
        return UIColor.lightGray
    }()
    
    open var indicatorColor: UIColor = UIColor.lightGray {
        didSet {
            indicator.color = indicatorColor
        }
    }
    
    private let defaultBoxColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.secondarySystemBackground
        }
        return UIColor.white
    }()
    
    open var boxColor: UIColor {
        get {
            if let color = box.backgroundColor {
                return color
            }
            return defaultBoxColor
        }
        set {
            box.backgroundColor = newValue
        }
    }
    
    private func onInit() {
        self.addSubview(box)
        box.backgroundColor = defaultBoxColor
        box.clipsToBounds = true
        box.layer.cornerRadius = 10.0
        box.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        box.layer.borderWidth = 0.5
        box.translatesAutoresizingMaskIntoConstraints = false
        box.widthAnchor.constraint(equalToConstant: 170).isActive = true
        box.heightAnchor.constraint(equalToConstant: 170).isActive = true
        box.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        box.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        self.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.color = defaultIndicatorColor
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: indicator.superview!.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: indicator.superview!.centerYAnchor, constant: -8).isActive = true

        self.addSubview(label)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.text = " "
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: box.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 12).isActive = true
    }
}

