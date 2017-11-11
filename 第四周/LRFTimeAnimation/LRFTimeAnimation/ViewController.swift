//
//  ViewController.swift
//  LRFTimeAnimation
//
//  Created by 吕瑞斐 on 2017/11/11.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var secLayer : CALayer?
    var minLayer : CALayer?
    var hourLayer : CALayer?
    var timer : DispatchSourceTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatHour()
        self.creatMin()
        self.creatSec()
        
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.never)
        timer?.setEventHandler(handler:{
            self.setTime()
        })
        timer?.resume()
    }
    func creatSec() {
    
        secLayer = CALayer()
        secLayer?.bounds = CGRect(x: 0, y: 0, width: 0.5, height: imageView.bounds.height/2 - 20)
        secLayer?.anchorPoint = CGPoint(x: 0.5, y: 1)
        secLayer?.position = CGPoint(x: imageView.bounds.width*0.5, y: imageView.bounds.height*0.5)
        secLayer?.backgroundColor = UIColor.red.cgColor
        imageView.layer.addSublayer(secLayer!)
  
    }
    func creatMin() {
        minLayer = CALayer()
        minLayer?.bounds = CGRect(x: 0, y: 0, width: 2, height: imageView.bounds.height/2 - 20)
        minLayer?.anchorPoint = CGPoint(x: 0.5, y: 1)
        minLayer?.position = CGPoint(x: imageView.bounds.width*0.5, y: imageView.bounds.height*0.5)
        minLayer?.backgroundColor = UIColor.black.cgColor
        imageView.layer.addSublayer(minLayer!)
    }
    func creatHour() {
        hourLayer = CALayer()
        hourLayer?.bounds = CGRect(x: 0, y: 0, width: 3, height: imageView.bounds.height/2 - 40)
        hourLayer?.anchorPoint = CGPoint(x: 0.5, y: 1)
        hourLayer?.position = CGPoint(x: imageView.bounds.width*0.5, y: imageView.bounds.height*0.5)
        hourLayer?.backgroundColor = UIColor.black.cgColor
        imageView.layer.addSublayer(hourLayer!)
    }
    func setTime() {
        let calendar = Calendar.current
        let dateComponent =  calendar.dateComponents(Set<Calendar.Component>(arrayLiteral: .second,.minute,.hour), from: Date.init())
        let second : Double? = Double(dateComponent.second!)
        let min : Double? = Double(dateComponent.minute!)
        let hour : Double? = Double(dateComponent.hour!)
     
        let secondAngle = 360/60 * second!
        let minAngle = 360/60 * min! + second!*(360/60/60)
        let hourAngle = 360/12 * hour! + min!*(360/12/60)
        secLayer?.transform = CATransform3DMakeRotation(CGFloat(secondAngle/180 * Double.pi), 0, 0, 1)
        minLayer?.transform = CATransform3DMakeRotation(CGFloat(minAngle/180 * Double.pi), 0, 0, 1)
        hourLayer?.transform = CATransform3DMakeRotation(CGFloat(hourAngle/180 * Double.pi), 0, 0, 1)
    }


}

