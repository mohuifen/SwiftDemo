//
//  LRFCollectionViewController.swift
//  LRFVerticalCollectionView
//
//  Created by Laura on 2017/10/31.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit

private let reuseIdentifier = "LRFCollectionViewCell"

class LRFCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //加了下面的那句话居然加载不出来，求解啊
    
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (UIScreen.main.bounds.width - 10*3)/2
            layout.itemSize = CGSize(width: width, height: width*1.2)
            layout.sectionInset.left = 10
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let imageView = cell.contentView.viewWithTag(10) as? UIImageView {
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
        
            let name = "\(indexPath.row%9+1)"
            print(name)
            
            imageView.image = UIImage(named: name)
        }
        
        return cell
    }

}
