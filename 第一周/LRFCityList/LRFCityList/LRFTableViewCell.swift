//
//  LRFTableViewCell.swift
//  LRFCityList
//
//  Created by Luckyfy on 2017/10/22.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFTableViewCell: UITableViewCell {
    var arrowImageView: UIImageView!
    var borderView: UIView!
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if !self.isEqual(nil) {
            // 设置UI
            borderView = UIView(frame: CGRect(x: 10, y: 0, width: self.frame.width - 20, height: self.frame.height))
            borderView.layer.borderColor = UIColor(displayP3Red: 208/255, green: 208/255, blue: 208/255, alpha: 1).cgColor
            borderView.layer.borderWidth = 1
            contentView.addSubview(borderView)
            
            label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: self.frame.height))
            borderView.addSubview(label)
            
            arrowImageView = UIImageView(frame: CGRect(x: borderView.frame.width - 40, y: 0, width: 30, height: borderView.frame.height))
            arrowImageView.contentMode = UIViewContentMode.center
            borderView.addSubview(arrowImageView)
            
            self.selectionStyle = UITableViewCellSelectionStyle.none
            
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        borderView.frame = CGRect(x: 10, y: 0, width: self.frame.width - 20, height: self.frame.height)
        label.frame = CGRect(x: label.frame.origin.x, y: 0, width: 200, height: borderView.frame.height)
        arrowImageView.frame = CGRect(x: borderView.frame.width - 40, y: 0, width: 30, height: borderView.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
