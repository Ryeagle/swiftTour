//
//  SwiftExtensions.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/6.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

extension CGPath {
    func forEach( body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(info: UnsafeMutableRawPointer?, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        apply(info: unsafeBody, function: callback)
    }
}

/*
 Find the first point in a path. Uses the CGPath extension created above.
 This is used to add the flying-saucer image at the beginning of
 the path it will animate on.
 */
extension UIBezierPath {
    func firstPoint() -> CGPoint? {
        var firstPoint: CGPoint? = nil
        
        cgPath.forEach { (element) in
            //Just want the first one, but we have to look at everything.
            guard firstPoint == nil else {return}
            assert(element.type == .moveToPoint, "Expected the first point to be a move")
            firstPoint = element.points.pointee
        }
        
        return firstPoint
    }
}
