//
//  AnimatedRoundButton.swift
//  AnimatedRoundButton
//
//  Created by Roman Sorochak <roman.sorochak@gmail.com> on 6/28/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


public enum ScaleState: CGFloat {
    case normal = 1
    case up = 1.2
    case down = 0.8
}


public enum TouchState: String {
    case began = "Began"
    case cancelled = "Cancelled"
    case ended = "Ended"
}

@IBDesignable
public class AnimatedRoundButton: UIView {
    
    static var defaultContentPaddingPercent: CGFloat = 0.05
    static var defaultScaleAnimationDuration: TimeInterval = 0.2
    static var defaultBackgroundColor = UIColor.clear
    static var defaultBorderColor = UIColor.red
    static var defaultBorderWidth: CGFloat = 1
    static var defaultTextColor: UIColor = UIColor.red
    
    
    private (set) var contentView: UIView!
    private (set) var label: UILabel!
    
    @IBInspectable public var paddingPercent: CGFloat = defaultContentPaddingPercent {
        didSet {
            setup()
        }
    }
    public var handlerButtonTouch: ((_ state: TouchState)->Void)?
    
    @IBInspectable public var animationDuration: TimeInterval = defaultScaleAnimationDuration {
        didSet {
            animationDurationForStates[.normal] = animationDuration
            animationDurationForStates[.up] = animationDuration
            animationDurationForStates[.down] = animationDuration
        }
    }
    public var animationDurationForStates: [ScaleState: TimeInterval] = [
        .normal : defaultScaleAnimationDuration,
        .up : defaultScaleAnimationDuration,
        .down : defaultScaleAnimationDuration
    ]
    public var scaleFactors: [ScaleState: CGFloat] = [
        .normal : ScaleState.normal.rawValue,
        .up : ScaleState.up.rawValue,
        .down : ScaleState.down.rawValue
    ]
    public var backgroundColorsForStates: [ScaleState: UIColor] = [
        .normal : defaultBackgroundColor,
        .up : defaultBackgroundColor,
        .down : defaultBackgroundColor
    ]
    @IBInspectable public var contentColor: UIColor = defaultBorderColor {
        didSet {
            contentView.backgroundColor = contentColor
        }
    }
    public var contentColorsForStates: [ScaleState: UIColor] = [
        .normal : UIColor.clear,
        .up : UIColor.red,
        .down : UIColor.clear
        ] {
        didSet {
            contentColor = contentColorsForStates[.normal] ?? contentColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = defaultBorderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var contentBorderWidth: CGFloat = defaultBorderWidth {
        didSet {
            contentView.layer.borderWidth = contentBorderWidth
        }
    }
    @IBInspectable public var borderColor: UIColor = defaultBorderColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    public var borderColorsForStates: [ScaleState: UIColor] = [
        .normal : UIColor.red,
        .up : UIColor.red,
        .down : UIColor.red
        ] {
        didSet {
            borderColor = borderColorsForStates[.normal] ?? borderColor
        }
    }
    @IBInspectable public var contentBorderColor: UIColor = defaultBorderColor {
        didSet {
            self.contentView.layer.borderColor = contentBorderColor.cgColor
        }
    }
    public var contentBorderColorsForStates: [ScaleState: UIColor] = [
        .normal : UIColor.red,
        .up : UIColor.red,
        .down : UIColor.red
        ] {
        didSet {
            contentBorderColor = contentBorderColorsForStates[.normal] ?? contentBorderColor
        }
    }
    @IBInspectable public var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    @IBInspectable public var textColor: UIColor? {
        get {
            return label.textColor
        }
        set {
            label.textColor = newValue
        }
    }
    @IBInspectable public var font: UIFont {
        get {
            return label.font
        }
        set {
            label.font = newValue
        }
    }
    public var textColorsForStates: [ScaleState: UIColor] = [
        .normal : UIColor.red,
        .up : UIColor.white,
        .down : UIColor.red
        ] {
        didSet {
            textColor = borderColorsForStates[.normal] ?? textColor
        }
    }
    
    
    /**
     * MARK: initialization
     */
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        setupContentView()
        setupLabel()
        
        makeRoundView(view: self)
        makeRoundView(view: contentView)
        
        backgroundColor = AnimatedRoundButton.defaultBackgroundColor
        contentColor = AnimatedRoundButton.defaultBackgroundColor
        
        borderWidth = AnimatedRoundButton.defaultBorderWidth
        contentBorderWidth = AnimatedRoundButton.defaultBorderWidth
        
        borderColor = AnimatedRoundButton.defaultBorderColor
        contentBorderColor = AnimatedRoundButton.defaultBorderColor
    }
    
    private func setupContentView() {
        if contentView == nil {
            contentView = UIView()
            addSubview(contentView)
        }
        let margin: CGFloat = self.frame.width * paddingPercent
        
        let frame = CGRect(
            x: bounds.origin.x + margin,
            y: bounds.origin.y + margin,
            width: bounds.width - margin * 2,
            height: bounds.height - margin * 2
        )
        
        contentView.frame = frame
    }
    
    private func setupLabel() {
        if label == nil {
            label = UILabel()
            contentView.addSubview(label)
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        textColor = textColorsForStates[.normal]
        label.frame = contentView.bounds
    }
    
    private func makeRoundView(view: UIView) {
        view.clipsToBounds = true
        
        let cornerRadius = (view.frame.width > view.frame.height ?
            view.frame.width / 2 : view.frame.height / 2)
        
        view.layer.cornerRadius = cornerRadius
    }
    
    
    /**
     * MARK: handle touches
     */
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        scale(.up)
        
        handlerButtonTouch?(.began)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesCancelled(touches, with: event)
        
        scale(.normal)
        
        touchesCancelled(touches, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        scale(.down)
        scale(.normal)
        
        self.handlerButtonTouch?(.ended)
    }
    
    
    /*
     * MARK: animations
     */
    
    private var animations = [ScaleState]()
    
    private func scale(_ scaleState: ScaleState, prevAnimIsFinished: Bool = false) {
        if !prevAnimIsFinished {
            animations.append(scaleState)
            guard animations.count == 1 else {
                return
            }
        }
        
        let animationDuration = animationDurationForStates[scaleState] ?? AnimatedRoundButton.defaultScaleAnimationDuration
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: { () -> Void in
                        
                        self.layer.backgroundColor = (self.backgroundColorsForStates[scaleState] ?? UIColor.clear).cgColor
                        self.layer.borderColor = (self.borderColorsForStates[scaleState] ?? UIColor.clear).cgColor
                        
                        self.contentView.layer.backgroundColor = (self.contentColorsForStates[scaleState] ?? UIColor.clear).cgColor
                        self.contentView.layer.borderColor = (self.contentBorderColorsForStates[scaleState] ?? UIColor.clear).cgColor
                        
                        let scaleFactor = self.scaleFactors[scaleState] ?? scaleState.rawValue
                        self.layer.transform = CATransform3DMakeScale(
                            scaleFactor,
                            scaleFactor,
                            1
                        )
                        let contentScaleFactor: CGFloat = {
                            switch scaleState {
                            case .up:
                                return self.frame.width / self.contentView.frame.width
                            default:
                                return scaleState.rawValue
                            }
                        }()
                        self.contentView.layer.transform = CATransform3DMakeScale(
                            contentScaleFactor,
                            contentScaleFactor,
                            1
                        )
                        
                        self.textColor = self.textColorsForStates[scaleState] ?? self.textColor
        }) { (bool) -> Void in
            self.animations.removeFirst()
            
            if !self.animations.isEmpty {
                self.scale(self.animations[0], prevAnimIsFinished: true)
            }
        }
    }
}
