//
//  ViewController.swift
//  LRFAddressBook
//
//  Created by Luara on 2017/10/17.
//  Copyright © 2017年 Beijing.iOS.LRFAddressBook. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView : UITableView?
    let sectionArray = ["A","B","C","D","F","L","R","Z"]
    var dataDic = Dictionary<String, Array<Any>>()
    
    let reuseIdentifier = "Names"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let navigationBar = LRFNavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        let navigationItem = UINavigationItem(title:"Names")
        navigationBar.setItems([navigationItem], animated: true)
        self.view.addSubview(navigationBar)
        
        
        self.dataDic = ["A": ["Aaron","Abbot","Abner"],"B":["Baird","Barry","Bert"],"C":["Cady","Caesar","Caitlyn"],"D":["Damia","Deva","Devin"],"L": ["Luara","Lorne","Louisa"],"F":["Fanny","Fallon","Farrah"],"R":["Rachel","Rain","Rainy"],"Z": ["Zenia","Zia","Zilli"]]

        
        self.tableView = UITableView(frame:CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.view.addSubview(self.tableView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setNavBarToTheView() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Names");
        navBar.setItems([navItem], animated: true);
    }

    //MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key: String! = sectionArray[section]
        let count = self.dataDic[key]?.count
        if count == nil {
            return 0
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        let key: String! = self.sectionArray[indexPath.section]
        cell?.textLabel?.text = self.dataDic[key]?[indexPath.row] as? String
        return cell!;
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionArray
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 44))
        label.font = UIFont(name: "PingFangSC-Medium", size: 18)
        label.text = sectionArray[section]
        view.addSubview(label)
        return view
    }

}

