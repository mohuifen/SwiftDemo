//
//  ViewController.swift
//  LRFTheHeartBeat
//
//  Created by Larua on 2017/11/11.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideImageView()
        
        let layer : CALayer? = CALayer()
        layer?.position = CGPoint(x: self.view.bounds.width/2, y: 120)
        layer?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer?.contents = UIImage(named: "heart")?.cgImage
        self.view.layer.addSublayer(layer!)
        
        let animation:CABasicAnimation? = CABasicAnimation()
        animation?.keyPath = "transform.scale"
        animation?.duration = 1.0
        animation?.toValue = 0.5
        animation?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation?.repeatCount = MAXFLOAT
        
        layer?.add(animation!, forKey: nil)
        
    }
    func hideImageView() {
        UIView.animate(withDuration: 2) {
            self.imageView.alpha = 0;
        }
    }

}

