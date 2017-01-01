//
//  LRFTableViewController.swift
//  LRFContacts
//
//  Created by Luckyfy on 2017/10/24.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class LRFTableViewController: UITableViewController {

    var dataDic:NSDictionary? = [:]
        //= {
//        let path : NSString = Bundle.main.path(forResource: "Contacts", ofType: "plist")! as NSString
//        let contentDic = NSDictionary(contentsOfFile: path as String)
//        let aDic:NSMutableDictionary
//        for item in (contentDic?.enumerated())! {
//            let dic:NSDictionary = item.element as NSDictionary
//            let array = NSMutableArray([LRFPersonModel])
//            for item in (dic.allValues.first as! NSArray).enumerated() {
//
//            }
//
//        }
        
//        let model =
//        return contentDic
        
    //}()
    var sectionArray:[Any] = []
    let reuseIdentifier: NSString! = "UITableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path : NSString = Bundle.main.path(forResource: "Contacts", ofType: "plist")! as NSString
        dataDic = NSDictionary(contentsOfFile: path as String)
        
        sectionArray = (dataDic?.allKeys)!
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataDic!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array:NSArray = dataDic?[sectionArray[section]] as! NSArray
        return array.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section] as? String
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier as String, for: indexPath)
//        if cell == nil {
//            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier! as String)
//        }
//        if
        let array:NSArray = dataDic![sectionArray[indexPath.section]] as! NSArray

        let dic = array[indexPath.row] as! NSDictionary
        cell.imageView?.image = UIImage(named: (dic["headPortraitStr"] as! String))
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.width)!/2
        cell.imageView?.layer.masksToBounds = true
        cell.textLabel?.text = dic["name"]! as? String
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*
         let array:NSArray = dataDic![sectionArray[indexPath.section]] as! NSArray
        
        let dic = array[indexPath.row] as! NSDictionary
        let infoCard : LRFInfoCardViewController = segue.destination
        infoCard.dic = dic
         */
    }
    

}
