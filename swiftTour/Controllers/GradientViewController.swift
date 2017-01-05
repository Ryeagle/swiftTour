//
//  GradientViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/4.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit

class GradientViewController: UIViewController {
    
    //MARK: Properties
    
    let gradientView = GradientView()
    let backgroundView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Convenience
    
    private func setupSubViews() {
        backgroundView.image = #imageLiteral(resourceName: "background")
        view.addSubview(backgroundView)
        
        gradientView.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100)
        view.addSubview(gradientView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        gradientView.text = "Render"
    }
}
