//
//  ViewController.swift
//  LRFTipCalculator
//
//  Created by Luara on 2017/10/16.
//  Copyright © 2017年 Beijing.iOS.LRFTipCalculator. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!

    @IBOutlet weak var slider: UISlider!
    
    var sliderValue: Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = LRFNavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64));
        let navigationItem = UINavigationItem(title: "Tip Calculator")
        navigationBar.setItems([navigationItem], animated: true)
        self.view.addSubview(navigationBar)
        
        self.sliderValue = Double(String(format:"%.2f",self.slider.value))!
        NotificationCenter.default.addObserver(self, selector:#selector(self.textFiledEditChanged), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        self.sliderValue = Double(String(format:"%.2f",self.slider.value))!
        self.tipTitleLabel.text = "Tip(" + "\(String(format:"%.0f",self.sliderValue * 100))" + "%)"
        self.calculate()
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == "" && string == "0" {
            return false
        }
        return true
    }
    
    //MARK: - Notification
    @objc func textFiledEditChanged(notification:NSNotification) {
        self.calculate();
    }
    
    //MARK: - Logic
    func calculate() {
        
        var consumption = self.textfield.text
        if consumption == "" {
            consumption = "0"
        }
        
        let tip = self.calculateTip(consumption:consumption!, tipRatio: Double(self.sliderValue))
        let total = self.calculateTotal(consumption:consumption!, tipRatio: Double(self.sliderValue))
        
        self.tipValueLabel.text = "$" + "\(tip)"
        self.totalValueLabel.text = "$" + "\(total)"
    }
    
    func calculateTip(consumption: String,tipRatio: Double) -> String {
        // 小费 = 消费 * 小费比例
        var tip:String = ""
        if let cost = Double(consumption) {
            tip = String(format: "%.2f", cost * tipRatio)
        }
        return tip
    }
    
    func calculateTotal(consumption: String,tipRatio: Double) -> String {
        // 总额 = 小费 + 消费
        var total:String = ""
        if let cost = Double(consumption) {
             total = String(format: "%.2f", cost * (1 + tipRatio))
        }
        return total
    }

}

