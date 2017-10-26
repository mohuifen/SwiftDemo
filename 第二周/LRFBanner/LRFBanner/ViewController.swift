//
//  ViewController.swift
//  LRFBanner
//
//  Created by Luckyfy on 2017/10/26.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
}

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray : Array! = { () -> Array<String>! in
        let array:Array! = ["0","1","2","3","4"]
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionView Delegate  DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LRFCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LRFCollectionViewCell", for: indexPath) as! LRFCollectionViewCell
        cell.imageView.image = UIImage(named: dataArray[indexPath.row] + ".jpg")
        cell.label.text = "My name is \(dataArray[indexPath.row]).jpg，I miss you"
        return cell
    }

    

}

