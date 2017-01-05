//
//  ProgressView.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/3.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit

class ProgressView: UIView {

    //MARK: Types
    
    struct Constants {
        struct ColorPalette {
            static let teal = UIColor(red: 0.27, green: 0.80, blue: 0.80, alpha: 1.0)
            static let orange = UIColor(red:0.90, green:0.59, blue:0.20, alpha:1.0)
            static let pink = UIColor(red:0.98, green:0.12, blue:0.45, alpha:1.0)
        }
    }
    
    //MARK: Properties
    
    let progressLayer = CAShapeLayer()
    let gradientLayer = CAGradientLayer()
    let stackView = UIStackView()
    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let gallonLabel = UILabel()
    let percentNumLabel = UILabel()
    let percentMarkLabel = UILabel()
    
    var range: CGFloat = 128
    var curValue: CGFloat = 0 {
        didSet {
            animateStroke()
            updatepercentNum()
        }
    }
    
    //MARK: View Life Cycle

    override func draw(_ rect: CGRect) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayers()
        setupSubViews()
    }

    //MARK: Private Method
    
    private func setupSubViews() {
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }

        percentNumLabel.text = "0"
        percentNumLabel.font = UIFont.systemFont(ofSize: 55)
        percentNumLabel.textColor = UIColor.black
        
        percentMarkLabel.text = "%"
        percentMarkLabel.font = UIFont.systemFont(ofSize: 24)
        percentMarkLabel.textColor = UIColor.black
        
        gallonLabel.text = "GALLON"
        gallonLabel.numberOfLines = 1
        gallonLabel.textAlignment = .center
        gallonLabel.font = UIFont.systemFont(ofSize: 12)
        gallonLabel.textColor = UIColor.black
        
        stackView1.axis = .horizontal
        stackView1.spacing = 3
        stackView1.addArrangedSubview(percentNumLabel)
        stackView1.addArrangedSubview(percentMarkLabel)

        stackView2.axis = .vertical
        stackView2.alignment = .fill
        stackView2.distribution = .fillEqually
        stackView2.addArrangedSubview(gallonLabel)
        
        stackView.axis = .vertical
        stackView.contentMode = .scaleToFill
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(stackView1)
        stackView.addArrangedSubview(stackView2)
        
    }
    
    private func setupLayers() {
        layer.backgroundColor = UIColor.clear.cgColor

        //Setup progess layer.
        progressLayer.position = CGPoint.zero
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0.0
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.black.cgColor
        
        let radius = (self.bounds.height / 2) - progressLayer.lineWidth
        let startAngle = CGFloat(-M_PI / 2)
        let endAngle = CGFloat(M_PI + M_PI / 2)
        let width = self.bounds.width
        let height = self.bounds.height
        let modelCenter = CGPoint(x: width / 2, y: height / 2)
        let path = UIBezierPath(arcCenter: modelCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressLayer.path = path.cgPath
        layer.addSublayer(progressLayer)
        
        //Setup gradient layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        gradientLayer.colors = [Constants.ColorPalette.teal.cgColor, Constants.ColorPalette.orange.cgColor, Constants.ColorPalette.pink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
    }
    
    private func animateStroke() {
        let fromeValue = progressLayer.strokeEnd
        let toValue = curValue / range
        
        let animation = CABasicAnimation(keyPath: "animation")
        animation.fromValue = fromeValue
        animation.toValue = toValue
        
        progressLayer.add(animation, forKey: "stroke")
        progressLayer.strokeEnd = toValue
    }
    
    
    private func updatepercentNum() {
        let percentage = Double(curValue) / Double(range)
        
        percentNumLabel.text = numberAsPercentage(Double(percentage))
    }
    
    func numberAsPercentage(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = ""
        return formatter.string(from: NSNumber(value: number))!
    }
    
}
