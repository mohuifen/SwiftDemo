//
//  LRFBaseTableViewCell.swift
//  LRFCityList
//
//  Created by Luckyfy on 2017/10/22.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

// 用的xib, 不知道为啥会崩溃
class LRFBaseTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.cornerRadius = 4
        borderView.layer.borderColor = UIColor(displayP3Red: 208/255, green: 208/255, blue: 208/255, alpha: 1).cgColor
        borderView.backgroundColor = UIColor(displayP3Red: 233/255, green: 233/255, blue: 233/255, alpha: 233/255)
        
        label.frame.origin.x = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
