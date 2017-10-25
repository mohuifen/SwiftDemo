//
//  LRFInfoCardViewController.swift
//  LRFContacts
//
//  Created by Luckyfy on 2017/10/24.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFInfoCardViewController: UIViewController {

    var dic: NSDictionary?
 
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
//        imageView.layer.cornerRadius = 50
//        imageView.layer.masksToBounds = true

        imageView.image = UIImage(named: dic?["headPortraitStr"] as! String)
        nameLabel.text = dic?["name"] as? String
        phoneLabel.text = self.phoneStr()
        emailLabel.text = dic?["email"] as? String
        notesTextView.text = dic?["notes"] as? String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - 给手机号添加分隔符 -
    func phoneStr() -> String {
        var phone : String = dic?["phone"] as! String
        
        var insertIndex :Int = 4
        var insetCount : Int = 0
        while insertIndex < phone.characters.count {
            phone.characters.insert("-", at: String.Index.init(encodedOffset: insertIndex))
            
            insetCount+=1
            insertIndex += insetCount + 4 * insetCount
        }
        return phone
    }

}
