//
//  LRFTableViewController.swift
//  LRFSwipeableCell
//
//  Created by Luckyfy on 2017/10/28.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFTableViewController: UITableViewController {

    var dataArray: [[String:String]]? = {
        do {
            let path = Bundle.main.path(forResource: "Contacts", ofType: "plist")
            if let path = Bundle.main.path(forResource: "Contacts", ofType: "plist") {
                let url = URL.init(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let array = try PropertyListDecoder().decode([[String:String]].self, from: data)
                return array
            }
        } catch let error {
            print(error)
        }
        return []

    }()
    
    lazy var shareAlert = UIActivityViewController(activityItems:[
        UIActivityType.message,
        UIActivityType.mail,
        
        ], applicationActivities: [

        ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = dataArray?.count {
            return count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if let dic = dataArray?[indexPath.row],
            let imageView = cell.contentView.viewWithTag(100) as? UIImageView,
            let label = cell.contentView.viewWithTag(200) as? UILabel {
            
            imageView.image = UIImage(named:dic["headPortraitStr"] ?? "")
            label.text = dic["name"]

        }
        cell.backgroundColor = UIColor(red: 252/255, green: 255/255, blue: 237/255, alpha: 1)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: UIContextualAction.Style.normal, title: "🗑️\nDelete") { (action, view, finished) in
            self.dataArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            finished(true)
        }
        delete.backgroundColor = UIColor(red: 123/255, green: 119/255, blue: 124/255, alpha: 1)
        let share = UIContextualAction(style: UIContextualAction.Style.normal, title: "🤗\nShare") { (action, view, finished) in
            self.present(self.shareAlert, animated: true, completion: {
                print("Share OK");
            })
            finished(true)

        }
        share.backgroundColor = UIColor(red: 252/255, green: 26/255, blue: 32/255, alpha: 1)

        let download = UIContextualAction(style: UIContextualAction.Style.normal, title: "⬇️\n Download ") { (action, view, finished) in
            print("Download OK");
            finished(true)
        }
        download.backgroundColor = UIColor(red: 8/255, green: 1/255, blue: 249/255, alpha: 1)

        return UISwipeActionsConfiguration(actions: [download,share,delete])
    }
 

}
