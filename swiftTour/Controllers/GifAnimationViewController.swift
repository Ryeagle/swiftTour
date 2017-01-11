//
//  GifAnimationViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/11.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit
import SwiftGifOrigin

class GifAnimationViewController: UIViewController {
    
    //MAKR: Types
    
    struct Constants {
        struct Gifs {
            static let catVideo = "cat-video"
        }
    }
    
    //MARK: Properties
    
    var gifImageView: UIImageView!
    

    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configImageView()
    }

    //MARK: Private Method
    
    private func configImageView() {
        gifImageView = UIImageView()
        self.view .addSubview(gifImageView)
        
        gifImageView.loadGif(name: Constants.Gifs.catVideo)
        
        gifImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}
