//
//  LRFNewTodoViewController.swift
//  LRFTodoList
//
//  Created by Laura on 2017/10/27.
//  Copyright © 2017年 Beijing.iOS.LRFTodoList. All rights reserved.
//

import UIKit

class LRFNewTodoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var model:LRFTodoModel?
    var selectedType:Int?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    let grayImageArray = [UIImage(named:"friend50_gray"),UIImage(named:"phone50_gray"),UIImage(named:"cart50_gray"),UIImage(named:"travel50_gray")]

    let imageArray = [UIImage(named:"friend50"),UIImage(named:"phone50"),UIImage(named:"cart50"),UIImage(named:"travel50")]
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let model = model {
            selectedType = model.type
            titleTextField.text = model.title
            datePickerView.date = model.time
            
            self.title = "Edit Todo"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action
    @IBAction func onDone(_ sender: Any) {
        if let type = selectedType,
            let title = titleTextField.text {
            
            if title.characters.count == 0 {
                return
            }
            
            var newModel = LRFTodoModel.init(type: type, title: title, time: datePickerView.date)
            
            if model != nil {
                model?.type = type
                model?.time = datePickerView.date
                model?.title = title
                
                newModel = model!
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newOrAdd"), object: nil, userInfo: ["model":newModel])
            navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - collectionView delegate and dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath)

        let imageView = cell.contentView.viewWithTag(100) as? UIImageView

        if selectedType == indexPath.row {
            imageView?.image = imageArray[indexPath.row]
        } else {
            imageView?.image = grayImageArray[indexPath.row]
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedType = indexPath.row
        collectionView.reloadData()
    }
    // MARK: - 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}
