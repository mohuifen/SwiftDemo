//
//  LRFTodoListTableViewController.swift
//  LRFTodoList
//
//  Created by 吕瑞斐 on 2017/10/27.
//  Copyright © 2017年 Beijing.iOS.LRFTodoList. All rights reserved.
//

import UIKit

class LRFTodoModel: NSObject {
    var type:Int
    var title:String
    var time:Date
    var index:Int
    
    convenience init(type:Int, title:String, time:Date) {
       self.init(type: type, title: title, time: time, index: -1)
    }
    init(type:Int, title:String, time:Date, index: Int) {
        self.type = type
        self.title = title
        self.time = time
        self.index = index
    }
}

class LRFTodoListTableViewController: UITableViewController {

    var dataArray:[LRFTodoModel]? = []
    
    let imageArray = [UIImage(named:"friend60"),UIImage(named:"phone60"),UIImage(named:"cart60"),UIImage(named:"travel60")]
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView.init()
        for index in 1...5 {
            let model = LRFTodoModel.init(type: index%4, title: "\(index)", time: Date.init(timeIntervalSinceNow: 10000))
            dataArray?.insert(model, at: 0)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(onAddOrEditModel(notification:)), name: NSNotification.Name(rawValue: "newOrAdd"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifation
    @objc func onAddOrEditModel(notification: NSNotification) {
        if let model = notification.userInfo!["model"] as? LRFTodoModel {
            if model.index >= 0 {// edit
                dataArray![model.index] = model
            } else { //add
                dataArray?.insert(model, at: 0)
            }
            tableView.reloadData()
        }
    }
    // MARK: - Action
    @IBAction func onEdit(_ sender: Any) {
        self.tableView.setEditing(!tableView.isEditing, animated: true)
        if let edit = sender as? UIBarButtonItem {
            if tableView.isEditing {
                
                edit.title = "Done"
            } else {
                edit.title = "Edit"
            }
        }
        
    }
  
    // MARK: - Logic
    func imageForType(type: Int) -> UIImage {
       
        if let image = imageArray[type] {
            return image
        }
        return UIImage()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if let model = dataArray?[indexPath.row] {
            
            model.index = indexPath.row
            
            cell.imageView?.image = self.imageForType(type: model.type)
            cell.textLabel?.text = model.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
          
            cell.detailTextLabel?.text = dateFormatter.string(from: model.time)

        }
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let model = dataArray?[indexPath.row]{
            model.index = indexPath.row
            // 设置传递的参数
            self.performSegue(withIdentifier: "edit", sender: model)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if let model = dataArray?.remove(at: fromIndexPath.row) {
            dataArray?.insert(model, at: to.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "edit" {
            if let destination = segue.destination as? LRFNewTodoViewController,
                let model = sender as? LRFTodoModel{
                destination.model = model
            }
            
        }
    }
    

}
