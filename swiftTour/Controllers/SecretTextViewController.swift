//
//  SecretTextViewController.swift
//  swiftTour
//
//  Created by Ryeagler on 2017/1/7.
//  Copyright © 2017年 Ryeagle. All rights reserved.
//

import UIKit
import SnapKit

class SecretTextViewController: UIViewController {
    
    //MARK: Types
    
    struct Constants {
        struct Images {
            static let one = "one"
            static let two = "two"
            static let three = "three"
            static let four = "four"
            static let five = "five"
            static let six = "six"
            static let seven = "seven"
            static let eight = "eight"
            static let nine = "nine"
            static let ten = "ten"
        }
    }
    

    //MARK: Properties
    
    var backgroundImageView: UIImageView!
    var quoteLabel: FadingLabel!
    let animationDuration: TimeInterval = 1.0
    let switchingInterval: TimeInterval = 3.0
    var currentIndex = 0
    
    let quotes = [
        Quote(quote: "\"The unexamined life is not worth living.\"", author: "Socrates", image: UIImage(named: Constants.Images.one)!),
        Quote(quote: "\"The most beautiful thing we can experience is the mysterious. It is the source of all true art and science.\"", author: "Albert Einstein", image: UIImage(named: Constants.Images.two)!),
        Quote(quote: "\"I do not steal victory.\"", author: "Alexander the Great", image: UIImage(named: Constants.Images.three)!),
        Quote(quote: "\"The key to immortality is first living a life worth remembering.\"", author: "Bruce Lee", image: UIImage(named: Constants.Images.four)!),
        Quote(quote: "\"Decide... whether or not the goal is worth the risks involved. If it is, stop worrying....\"", author: "Amelia Earhart", image: UIImage(named: Constants.Images.five)!),
        Quote(quote: "\"I've failed over and over and over again in my life and that is why I succeed.\"", author: "Michael Jordan", image: UIImage(named: Constants.Images.six)!),
        Quote(quote: "\"Kind words can be short and easy to speak, but their echoes are truly endless.\"", author: "Mother Teresa", image: UIImage(named: Constants.Images.seven)!),
        Quote(quote: "\"Live as if you were to die tomorrow; learn as if you were to live forever.\"", author: "Mahatma Gandhi", image: UIImage(named: Constants.Images.eight)!),
        Quote(quote: "\"Somewhere, something incredible is waiting to be known.\"", author: "Carl Sagan", image: UIImage(named: Constants.Images.nine)!),
        Quote(quote: "\"It is not death that a man should fear, but he should fear never beginning to live.\"", author: "Marcus Aurelius", image: UIImage(named: Constants.Images.ten)!),
        ]

    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configBackgroudImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCharacterLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBackgroundImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Method
    
    private func setupCharacterLabel() {
        quoteLabel = FadingLabel(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.textAlignment = NSTextAlignment.center
        quoteLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        quoteLabel.textColor = UIColor.white
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.numberOfLines = 0
        
        self.view.addSubview(quoteLabel)
        
        // Constraints.
        NSLayoutConstraint.activate([
            quoteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            quoteLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            quoteLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.25)
            ])

//        quoteLabel.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
//            make.width.equalTo(self.view.frame.width / 1.25)
//        }
    }
    
    private func configBackgroudImageView() {
        self.backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(backgroundImageView)
        
        self.backgroundImageView.image = quotes[currentIndex].image
    }
    
    private func animateBackgroundImageView() {
        swithQuote()
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock { 
            let delay = DispatchTime.now() + Double(Int64(self.switchingInterval * TimeInterval(NSEC_PER_SEC))) / Double(TimeInterval(NSEC_PER_SEC))
            DispatchQueue.main.asyncAfter(deadline: delay, execute: { 
                self.animateBackgroundImageView()
            })
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        backgroundImageView.layer.add(transition, forKey: kCATransition)
        backgroundImageView.image = quotes[currentIndex].image
        
        CATransaction.commit()
        
        //Increase index to switch both the quote and image to the next
        currentIndex = currentIndex < quotes.count - 1 ? currentIndex + 1 : 0
    }
    
    private func swithQuote() {
        quoteLabel.text = ""
        quoteLabel.text = quotes[currentIndex].quote + "\n\n" + quotes[currentIndex].author
    }
    
    //MARK: Status Bar
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
