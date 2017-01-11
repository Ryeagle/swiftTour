//
//  Quote.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/7.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit

class Quote {
    
    //MARK: Properties
    
    let quote: String
    let author: String
    let image: UIImage
    
    //MARK: Initializers
    
    init(quote: String, author: String, image: UIImage) {
        self.quote = quote
        self.author = author
        self.image = image
    }
}
