//
//  LRFTableViewController.swift
//  LRFSwipeableCell
//
//  Created by Luckyfy on 2017/10/28.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFTableViewController: UITableViewController {

    var dataArray: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            if let path = Bundle.main.path(forResource: "Contacts", ofType: "plsit") {
                let url = URL.init(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let array = try PropertyListDecoder().decode([String].self, from: data)
                dataArray.append((array as? [String:String])!)
            }
        } catch let error {
            print(error)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = dataArray.count {
            return count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if let image = dataArray[indexPath.row]["headPortraitStr"]
            let name = dataArray[indexPath.row]["name"] {
            cell.imageView?.image = image
            cell.textLabel?.text = name

        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
