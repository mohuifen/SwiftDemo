//
//  LRFNavigationBar.swift
//  LRFAddressBook
//
//  Created by Luara on 2017/10/17.
//  Copyright © 2017年 Beijing.iOS.LRFAddressBook. All rights reserved.
//

import UIKit

class LRFNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super .layoutSubviews()
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: 64)
        for aView:UIView in self.subviews {
            
            let classString = NSStringFromClass(aView.classForCoder)
            if classString.contains("Background") {
                aView.frame = self.bounds;
            } else if classString.contains("ContentView") {
                var frame = aView.frame;
                frame.origin.y = 20
                frame.size.height = self.bounds.size.height - frame.origin.y
                aView.frame = frame;
            }
        }
    }

}
