//
//  ViewController.swift
//  LRFTimer
//
//  Created by Luara on 2017/10/19.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Action
    @IBAction func onStart(_ sender: Any) {
        // 开启计时器
        if !(timer != nil) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: {(timer:Timer) in
                //每0.3s ， 然后刷新label 的显示
                self.addTime()
            })
        }
    }
    @IBAction func onPause(_ sender: Any) {
        // 暂停计时器
        if (timer != nil) {
            timer.invalidate()
            timer = nil
        }
    }
    @IBAction func onReset(_ sender: Any) {
        timeLabel.text = "0.0"
    }
    
    func addTime() {
        let roundDown = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        var timeNumber = NSDecimalNumber(string: timeLabel.text)
        timeNumber = timeNumber.adding(NSDecimalNumber(string:"0.1"), withBehavior: roundDown)
        timeLabel.text = String(format: "%.1f",timeNumber.floatValue)
        
    }
}

