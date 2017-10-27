//
//  LRFTableViewController.swift
//  LRFContacts
//
//  Created by Luckyfy on 2017/10/24.
//  Copyright © 2017年 Luara. All rights reserved.
//


import UIKit

class LRFTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 20, y: 0, width: 45, height: 45)
        self.imageView?.center.y = self.frame.height/2
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.width)!/2
        self.imageView?.layer.masksToBounds = true
    }
}

class LRFTableViewController: UITableViewController {

    var dataDic:[String:[[String:String]]]? = [:]
    // 尝试懒加载，封装model 失败
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
    var sectionArray:[String]?
    let reuseIdentifier: String! = "LRFTableViewCell"
    var indexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "Contacts", ofType: "plist")
        if let datas = NSDictionary(contentsOfFile: path!) as? [String:[[String:String]]] {
            dataDic = datas
        }
        guard let dataDic = dataDic else { return }
        sectionArray = dataDic.keys.map{$0}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let datas = sectionArray else { return 0 }
        return datas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dic = dataDic, let sections = sectionArray else { return 0 }
        if let datas = dic[sections[section]] {
            return datas.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        view.backgroundColor = self.view.backgroundColor
        let label : UILabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 40))
        label.textColor = UIColor(red: 107/255, green: 71/255, blue: 48/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = sectionArray![section].uppercased()
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let dic = dataDic,
            let sections = sectionArray,
            let datas = dic[sections[indexPath.section]]?[indexPath.row] {
            cell.imageView?.image = UIImage(named: datas["headPortraitStr"] ?? "")
            cell.textLabel?.text = datas["name"]
        }
        cell.imageView?.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor(red: 86/255, green: 83/255, blue: 101/255, alpha: 1)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        if let dic = dataDic,
            let sections = sectionArray,
            let datas = dic[sections[indexPath.section]]?[indexPath.row] {
            self.performSegue(withIdentifier: "info", sender: datas)
        }
        

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info",let vc = segue.destination as? LRFInfoCardViewController {
            vc.dic = sender as? [String: String]
        }
    }
    

}
