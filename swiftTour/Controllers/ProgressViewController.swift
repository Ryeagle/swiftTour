//
//  ProgressViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/3.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit

class ProgressViewController: UIViewController {

    //MARK: Properties
    
    var incrementProgeressButton: UIButton!
    var progressView: ProgressView!

    
    //MARK: View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Public
    
    func addValue(_ sender: AnyObject) {
        guard progressView.curValue < progressView.range else {
            return
        }
        
        progressView.curValue += 8
    }

    
    //MARK: Private Method
    
    private func setupSubviews() {
        
        incrementProgeressButton = UIButton(type: .contactAdd)
        incrementProgeressButton.addTarget(self, action: #selector(ProgressViewController.addValue(_:)), for: .touchUpInside)
        self.view.addSubview(incrementProgeressButton)
        
        progressView = ProgressView()
        progressView.backgroundColor = UIColor.white
        progressView.curValue = 0
        progressView.range = 128
        self.view.addSubview(progressView)
        
        
        incrementProgeressButton.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(-50)
            make.centerX.equalTo(self.view)
        }
        
        progressView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(300)
            make.center.equalTo(self.view)
        }
    }

    private func configProgressView() {
        progressView.curValue = 0
        progressView.range = 128
    }
}
