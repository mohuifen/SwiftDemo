//
//  ViewController.swift
//  LRFTwitterLogo
//
//  Created by Larua on 2017/11/11.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var bgImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layer : CALayer? = CALayer()
        layer?.position = view.center
        layer?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer?.contents = UIImage(named: "twitter logo mask")?.cgImage
        
        let maskAnimation : CAKeyframeAnimation? = CAKeyframeAnimation(keyPath: "bounds")
        maskAnimation?.duration = 2
        let startFrame : CGRect? = layer?.frame
        let tmpFrame : CGRect = CGRect(x: 0, y: 0, width: 75, height: 75)
        let endFrame : CGRect = CGRect(x: 0, y: 0, width: 2000, height: 2000)
        maskAnimation?.values = [startFrame!,tmpFrame,endFrame]
        maskAnimation?.timingFunctions = [
            CAMediaTimingFunction(name: "easeInEaseOut"),
            CAMediaTimingFunction(name: "easeOut"),
            CAMediaTimingFunction(name: "easeOut")]
        maskAnimation?.fillMode = kCAFillModeForwards
        maskAnimation?.isRemovedOnCompletion = false
        
        
        layer?.add(maskAnimation!, forKey: nil)
        
        bgImageView.layer.mask = layer

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

