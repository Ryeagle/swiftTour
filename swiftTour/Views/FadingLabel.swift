//
//  FadingLabel.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/10.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

class FadingLabel: CharacterLabel {

    override var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }
        
        set {
            super.attributedText = newValue
            self.animateIn { (finished) in
                self.animateIn(nil)
            }

        }
    }
    
    override func initialTextLayerAttributes(_ textLayer: CATextLayer) {
        textLayer.opacity = 0
    }
    
    //MARK: Convenience
    
    func animateIn(_ completion: ((_ finished: Bool) -> Void)?) {
        for textLayer in characterTextLayers {
            let duration = (TimeInterval(arc4random() % 100) / 200.0) + 0.25
            let delay = TimeInterval(arc4random() % 100) / 500.0
            
            CLMLayerAnimation.animation(textLayer, duration: duration, delay: delay, animations: { 
                textLayer.opacity = 1
            }, completion: nil)
        }
    }
    
    func animateOut(_ complecation: ((_ finished: Bool) -> Void)?) {
        
    }
}
