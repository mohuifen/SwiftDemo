//
//  ViewController.swift
//  LRFCityList
//
//  Created by Luckyfy on 2017/10/20.
//  Copyright © 2017年 Luara. All rights reserved.
//

import UIKit

class NodeModel: NSObject {
    public var isRoot : Bool///< 是否是第一级
    public var isLeaf : Bool///< 是否是叶子节点
    public var isExpand : Bool// 是否展开

    public var name : String = ""
    public var parentId : Int?///< 父节点id
    public var id : Int?///< 自己的id
    public var level : Int?///< 所在层级

    init(name : String, isRoot:Bool, isLeaf : Bool, isExpand: Bool, id : Int, parentId : Int , level:Int) {
        self.name = name
        self.isRoot = isRoot
        self.isLeaf = isLeaf
        self.isExpand = isExpand
        self.id = id
        self.parentId = parentId
        self.level = level

    }
}
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    let reuseIdentifier = "LRFTableViewCell"

    var reloadIndexPaths:NSMutableArray = {
        let array = NSMutableArray(array: [])
        return array;
    }()
    var originDataArray: NSMutableArray = {
        let array = NSMutableArray(array: [])
        return array;
    }()
    var dataArray:NSMutableArray = {
        let array = NSMutableArray(array: [])
        return array;
    }()
    
    //MARK: - Lifycicle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadNodePlist()
        self.setData()
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.register(LRFTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Logic
    func loadNodePlist()  {
        let path = Bundle.main.path(forResource: "Nodes", ofType: "plist")
        let plistArray:NSArray! = (NSArray(contentsOfFile: path!))!
        
        for item in plistArray.enumerated() {
            let dic :NSDictionary = item.element as! NSDictionary
            let name = dic["name"] as! String
            let isRoot = dic["isRoot"] as! Bool
            let isLeaf = dic["isLeaf"] as! Bool
            let isExpand = dic["isExpand"] as! Bool
            let id = dic["id"] as! String
            let parentId = dic["parentId"] as! String
            let level = dic["level"] as! String
            
            let nodeModel = NodeModel(name: name, isRoot: isRoot, isLeaf: isLeaf, isExpand: isExpand, id: Int(id)!, parentId:Int(parentId)! , level: Int(level)!)
            originDataArray.add(nodeModel)
        }
    }
    
    func setData() {
        // 获取root
        for item in originDataArray.enumerated() {
            let nodeModel:NodeModel = item.element as! NodeModel
            if nodeModel.isRoot {
                dataArray.add(NSMutableArray.init(object: nodeModel))
            }
        }
        //获取二级节点数据,,, 是否默认展开二级节点，由 plist 配置决定的
        for item in dataArray.enumerated() {
            let array : NSMutableArray = item.element as! NSMutableArray
            let rootNodeModel:NodeModel = array.firstObject as! NodeModel
            
            if rootNodeModel.isExpand {
                for item in originDataArray.enumerated() {
                    let nodeModel:NodeModel = item.element as! NodeModel
                    if nodeModel.parentId == rootNodeModel.id {
                        array.add(nodeModel)
                    }
                    
                }
            }
        }
    }
    // 刷新当前cell
    func reloadCell(cell:LRFTableViewCell,currentNode:NodeModel) {
        let image = cell.arrowImageView?.image
        
        switch currentNode.level {
        case 1?:
            let fold = UIImage(named: "fold")
            let unfold = UIImage(named: "unfold")
            if (image?.isEqual(fold))! {
                cell.arrowImageView?.image = unfold
            } else {
                cell.arrowImageView?.image = fold
            }
        case 2?:
            let arrowUp = UIImage(named: "arrow_up")
            let arrowRight = UIImage(named: "arrow_right")
            if (image?.isEqual(arrowUp))! {
                cell.arrowImageView?.image = arrowRight
            } else {
                cell.arrowImageView?.image = arrowUp
            }
        default: break
        }
    }
    // 点击展开，计算需要插入数据
    func expandNode(parentID: Int, insertIndex: Int, section:Int) {
        var insetIndex = insertIndex
        for item in originDataArray.enumerated() {
            let nodeModel : NodeModel = item.element as! NodeModel
            if nodeModel.parentId == parentID {
                insetIndex += 1
                let rowsArray :NSMutableArray = dataArray[section] as! NSMutableArray
                rowsArray.insert(nodeModel, at: insetIndex)
                reloadIndexPaths.add(NSIndexPath(row: insetIndex, section: section))
            }
        }
    }
    // 点击折叠，计算需要删除的数据
    func foldBy(parentID: Int, level: Int, index:Int, section:Int )  {
        var index = index

        let rowArrays : NSMutableArray = dataArray[section] as! NSMutableArray
        for item in (rowArrays.copy() as! NSArray).enumerated() {
            
            if item.offset > index {
                let nodeModel : NodeModel = item.element as! NodeModel
                if level == 1 { // 是root, 删除全部的子节点
                    index += 1
                    nodeModel.isExpand = false
                    rowArrays.remove(nodeModel)
                    reloadIndexPaths.add(NSIndexPath(row: index, section: section))
                } else {// 不是root, 则找自己的子节点删除即可
                    if nodeModel.parentId == parentID {
                        if nodeModel.level! > level {
                            index += 1
                            nodeModel.isExpand = false
                            rowArrays.remove(nodeModel)
                            reloadIndexPaths.add(NSIndexPath(row: index, section: section))
                            
                        }
                    }
                }
            }
        }
    }
    /*
     会崩溃，求厉害的朋友帮忙看下
    func foldNode(parentID: Int, insertIndex: Int, section:Int) {
        var insetIndex = insertIndex

        let rowArrays : NSMutableArray = dataArray[section] as! NSMutableArray
        for item in (rowArrays.copy() as! NSArray).enumerated() {
            let nodeModel : NodeModel = item.element as! NodeModel
            if nodeModel.parentId == parentID {
                insetIndex += 1
                rowArrays.remove(nodeModel)
                reloadIndexPaths.add(NSIndexPath(row: insetIndex, section: section))
                
                if nodeModel.isExpand {
                    self .foldNode(parentID: nodeModel.id!, insertIndex: insetIndex, section: section);

                }
                nodeModel.isExpand = false

            }
        }
    }
 */
    
    //MARK: - TableView Delegate And DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array : NSArray =  dataArray[section] as! NSArray
        let count : NSInteger = array.count
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: LRFTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LRFTableViewCell
        if (cell.isEqual(nil)) {
            cell = LRFTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        
        let rowsArray :NSMutableArray = dataArray[indexPath.section] as! NSMutableArray
        let currentNode : NodeModel = rowsArray[indexPath.row] as! NodeModel
        
        cell.borderView.layer.cornerRadius = 0
        cell.label?.text = currentNode.name;

        if currentNode.level == 1 {
            if currentNode.isExpand {
                cell.arrowImageView?.image = UIImage(named: "unfold")// 减号
            } else {
                cell.arrowImageView?.image = UIImage(named: "fold")// 加号
            }
            cell.borderView.backgroundColor = UIColor(displayP3Red: 233/255, green: 233/255, blue: 233/255, alpha: 233/255)
            cell.borderView.layer.cornerRadius = 4

            
            cell.label?.frame.origin.x = 10
        }
        if currentNode.level == 2 {
            cell.borderView.backgroundColor = UIColor(displayP3Red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            cell.label?.frame.origin.x = 25
            if currentNode.isExpand {
                cell.arrowImageView?.image = UIImage(named: "arrow_right")// 向右
            } else {
                cell.arrowImageView?.image = UIImage(named: "arrow_up")// 向上
            }
            
        }
        if currentNode.level == 3 {
            cell.borderView.backgroundColor = UIColor(displayP3Red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
            cell.label?.frame.origin.x = 35
            cell.arrowImageView?.image = nil

        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rowsArray :NSMutableArray = dataArray[indexPath.section] as! NSMutableArray
        let currentNode : NodeModel = rowsArray[indexPath.row] as! NodeModel
        
        let cell : LRFTableViewCell = tableView.cellForRow(at: indexPath) as! LRFTableViewCell
        self.reloadCell(cell: cell,currentNode: currentNode)

        reloadIndexPaths .removeAllObjects()

        if !currentNode.isLeaf {
            if !currentNode.isExpand {
                self.expandNode(parentID: currentNode.id!, insertIndex: indexPath.row, section: indexPath.section)
                tableView.beginUpdates()
                tableView.insertRows(at: reloadIndexPaths as! [IndexPath], with: UITableViewRowAnimation.top)
                tableView.endUpdates()
                currentNode.isExpand = true
            } else {
                self.foldBy(parentID: currentNode.id!, level: currentNode.level!, index: indexPath.row, section: indexPath.section)
//                self.foldNode(parentID: currentNode.id!, insertIndex: indexPath.row, section: indexPath.section)
                tableView.beginUpdates()
                tableView.deleteRows(at: reloadIndexPaths as! [IndexPath], with: UITableViewRowAnimation.top)
                tableView.endUpdates()

                currentNode.isExpand = false

            }
            
        }
        
    }
}

