//
//  LRFNewTodoViewController.swift
//  LRFTodoList
//
//  Created by 吕瑞斐 on 2017/10/27.
//  Copyright © 2017年 Beijing.iOS.LRFTodoList. All rights reserved.
//

import UIKit

class LRFNewTodoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var model:LRFTodoModel?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDone(_ sender: Any) {
    }
    
}
