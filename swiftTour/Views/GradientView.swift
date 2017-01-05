//
//  GradientView.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/4.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit

class GradientView: UIView {

    //MARK: Types
    struct Constants {
        struct Fonts {
            static let loadingLabel = "HelveticaNeue-UltraLight"
        }
    }
    
    //MARK: Properties
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        //Configure gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        gradientLayer.colors = colors
        
        let locations = [NSNumber(value: 0.25), NSNumber(value: 0.5), NSNumber(value: 0.75)]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    let textAttributes: [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        return [NSFontAttributeName: UIFont(name:Constants.Fonts.loadingLabel, size: 70.0)!, NSParagraphStyleAttributeName: style]
    }()
    
    var text: String! {
        didSet {
            setNeedsLayout()
            
            //Create a tmppotary graphic context in order to render the text as an image
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.draw(in: bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndPDFContext()
            
            //Use image to create a mask on the gradient layer.
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: 0, dy: 0)
            maskLayer.contents = image?.cgImage
            
            gradientLayer.mask = maskLayer
        }
    }
    
    //MARK: View Life Cycle
    
    override func layoutSubviews() {
        configSubViews()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(gradientLayer)

        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 1.7
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }

    
    //MARK: Private
    
    private func configSubViews() {
        gradientLayer.frame = bounds
    }

}
