//
//  GlobalFunctions.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/7.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

func delay(seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}
