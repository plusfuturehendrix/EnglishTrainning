//
//  PulsingView.swift
//  EnglishTrainning
//
//  Created by Danil Bochkarev on 29.03.2023.
//

import UIKit
import AnchorKit

class PulsingView: UIView {
    
    var checker = false {
        didSet {
            updateColors()
        }
    }
    
    var mainColor: CGColor = Constant.mainColor {
        didSet {
            mainLayer.strokeColor = mainColor
        }
    }
    
    var pulsingColor: CGColor = Constant.pulsingColor {
        didSet {
            pulsingLayer.strokeColor = pulsingColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        updateColors()
        layer.addSublayer(pulsingLayer)
        layer.addSublayer(mainLayer)
        pulsingLayer.add(animationGroup, forKey: nil)
    }
    
    // остальной код
    private func updateColors() {
        if checker {
            mainColor = UIColor(red: 0.12, green: 0.56, blue: 1, alpha: 1).cgColor
            pulsingColor = UIColor(red: 0, green: 0.75, blue: 1, alpha: 1).cgColor
        } else {
            mainColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1).cgColor
            pulsingColor = UIColor(red: 1, green: 0.6, blue: 0.6, alpha: 1).cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var animationGroup: CAAnimationGroup = {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [expandingAnimation,
                                     fadingAnimation]
        animationGroup.duration = 1.5
        animationGroup.repeatCount = .infinity
        return animationGroup
    }()
    
    private lazy var fadingAnimation: CABasicAnimation = {
        let fadingAnimation = CABasicAnimation(keyPath: "opacity")
        fadingAnimation.fromValue = 1
        fadingAnimation.toValue = 0
        return fadingAnimation
    }()
    
    private lazy var expandingAnimation: CABasicAnimation = {
        let expandingAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandingAnimation.fromValue = 1
        expandingAnimation.toValue = 1.4
        return expandingAnimation
    }()
    
    private let mainLayer: CAShapeLayer = circleLayer(color: Constant.mainColor)
    private let pulsingLayer: CAShapeLayer = circleLayer(color: Constant.pulsingColor)
    
    private static func circleLayer(color: CGColor) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.path = Constant.bezierPath.cgPath
        circleLayer.lineWidth = 20
        circleLayer.strokeColor = color
        circleLayer.fillColor = UIColor.clear.cgColor
        return circleLayer
    }
    
    private enum Constant {
        static let bezierPath: UIBezierPath = .init(arcCenter: CGPoint.zero,
                                                    radius: 75 / 2,
                                                    startAngle: -(CGFloat.pi / 2),
                                                    endAngle: -(CGFloat.pi / 2) + (2 * CGFloat.pi),
                                                    clockwise: true)
        static let mainColor: CGColor = UIColor(red: 0.12, green: 0.56, blue: 1, alpha: 1).cgColor
        static let pulsingColor: CGColor = UIColor(red: 0, green: 0.75, blue: 1, alpha: 1).cgColor
    }
}
