//
//  ViewController.swift
//  LRFSimpleCollectionView
//
//  Created by Laura on 2017/10/30.
//  Copyright © 2017年 Laura. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let identifier = "Cell"
    let width:Int = Int(UIScreen.main.bounds.width)
    var labelWidth: Int {
        return (self.width - 10*5)/4
    }
    let cellCount = 11

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControlYConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //    var collectionView:UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        layout.itemSize = CGSize(width: width - 5*20, height: 100)
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 100, width: width, height: 260), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor(red: 227/255, green: 254/255, blue: 232/255, alpha: 1)
        collectionView?.dataSource = self
        collectionView?.isPagingEnabled = true
        if let view = collectionView {
            self.view.addSubview(view)
        }
 */
        
        collectionView.frame = CGRect(x: 0, y: 100, width: width, height: labelWidth*2+3*10)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = collectionView.frame.size
        }
        pageControl.numberOfPages = self.pageNumber()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let y = collectionView.frame.origin.y + collectionView.frame.height + 10
        pageControlYConstraint.constant = y
        pageControl.frame.origin.y = y
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageNumber() -> Int {
        return Int(cellCount/8)+1
    }
    
    @IBAction func pageControlValueChanged(_ sender: Any) {
        
        collectionView.scrollToItem(at: IndexPath.init(row: pageControl.currentPage, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }

}
extension ViewController:UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x/collectionView.frame.width)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pageNumber()
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        
        
        for item in 1...8 {
            if let label = cell.contentView.viewWithTag(item*10) as? UILabel {
                // 显示的文本
                let text = item + indexPath.row*8 - 1
                if cellCount - 1 >= text {
                    label.text = "\(text)"
                    label.backgroundColor = UIColor.init(red: 155/255, green: 116/255, blue: 71/255, alpha: 1)
                    
                    // 算坐标 ，好麻烦。哈哈哈哈
                    let x = (item > 4 ? item - 4 : item) * 10 + labelWidth*((item > 4 ? item - 4 : item) - 1)
                    let y = item > 4 ? 10+labelWidth+10 : 10
                    label.frame = CGRect(x: x, y: y, width: labelWidth, height: labelWidth)
                    
                } else {
                    label.text = ""
                    label.backgroundColor = .clear
                }
            }
        }
        return cell
    }
}

