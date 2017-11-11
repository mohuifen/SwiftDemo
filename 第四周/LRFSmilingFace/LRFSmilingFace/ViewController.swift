//
//  ViewController.swift
//  LRFSmilingFace
//
//  Created by Larua on 2017/11/11.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var left: UIImageView!
    
    @IBOutlet weak var right: UIImageView!
    
    @IBOutlet weak var center: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.isHidden = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 不知道怎么设置弱引用的self
        
        
        //usingSpringWithDamping 阻尼系数(弹性) 越小越弹
        //initialSpringVelocity速率

        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.init(rawValue: 1), animations: {
            
            self.left.center = CGPoint(x: self.view.frame.size.width - self.left.center.x, y: self.left.center.y+30)
            
            self.right.center = CGPoint(x: self.view.frame.size.width - self.right.center.x, y: self.right.center.y+30)
            
            
            let frame:CGRect = CGRect(x: self.center.frame.origin.x, y: self.center.frame.origin.y, width: self.center.frame.size.width, height: 180)
            
            self.center.frame = frame
            
            self.view.layoutIfNeeded()
        }) { (finished) in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
                self.titleLabel.isHidden  = false
            }, completion: nil)
        }
       
    }


}

