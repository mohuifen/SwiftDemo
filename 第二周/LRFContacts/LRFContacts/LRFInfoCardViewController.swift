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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        imageView.image = UIImage(named: dic?["headPortraitStr"] as! String)
//        nameLabel.text = dic?["name"] as? String
//        phoneLabel.text = dic?["phone"] as? String
//        emailLabel.text = dic?["email"] as? String
//        notesTextView.text = dic?["notes"] as? String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
