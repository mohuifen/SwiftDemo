//
//  LRFInfoCardViewController.swift
//  LRFContacts
//
//  Created by Luckyfy on 2017/10/24.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFInfoCardViewController: UIViewController {

    var dic: [String: String]?
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        imageView.image = UIImage(named: dic?["headPortraitStr"] ?? "")
        nameLabel.text = dic?["name"]
        phoneLabel.text = self.phoneStr()
        emailLabel.text = dic?["email"]
        notesTextView.text = dic?["notes"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - 给手机号添加分隔符 -
    func phoneStr() -> String {
        var phone : String = dic?["phone"] ?? ""
        
        var insertIndex :Int = 4
        var insetCount : Int = 0
        while insertIndex < phone.count {
            phone.characters.insert("-", at: String.Index(encodedOffset: insertIndex))
            
            insetCount+=1
            insertIndex += insetCount + 4 * insetCount
        }
        return phone
    }

}
