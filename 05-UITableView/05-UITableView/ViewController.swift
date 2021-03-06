//
//  ViewController.swift
//  05-UITableView
//
//  Created by 冯志浩 on 16/10/25.
//  Copyright © 2016年 FZH. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let tableView = UITableView()
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    var dataSource: NSMutableArray = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFooterView()
        dataSource = NSMutableArray.init(array: ["2333","5555","asdf","xxfa","ddd","123"])
    }
    
    func setupTableView() -> Void {
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        tableView.delegate = self
        tableView.dataSource = self
        //隐藏没有数据的空白cell
        tableView.tableFooterView = UIView.init()
        self.view.addSubview(tableView)
    }
    //MARK: UITableViewDataSource
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FZHTableViewCell.init(style: .default, reuseIdentifier: "FZHTableViewCell")
        cell.titleLabel.text = dataSource[indexPath.row] as? String
        return cell
    }
   //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //是否可编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //接受的编辑类型
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        //此返回值对应左划删除
//        return .delete
        return UITableViewCellEditingStyle.init(rawValue: UITableViewCellEditingStyle.insert.rawValue | UITableViewCellEditingStyle.delete.rawValue)!
    }
    //具体操作的处理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func setupFooterView() -> Void {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.blue
        footerView.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 100, width: SCREEN_WIDTH, height: 100)
        
        let editBtn = UIButton()
        editBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        editBtn.tag = 1000
        editBtn.setTitle("编辑", for: .normal)
        editBtn.addTarget(self, action: #selector(btnDidTouch(btn:)), for: .touchUpInside)
        footerView.addSubview(editBtn)
        
        let selectAllBtn = UIButton()
        selectAllBtn.frame = CGRect(x: 80, y: 0, width: 50, height: 30)
        selectAllBtn.tag = 1001
        selectAllBtn.setTitle("全选", for: .normal)
        selectAllBtn.addTarget(self, action: #selector(btnDidTouch(btn:)), for: .touchUpInside)
        footerView.addSubview(selectAllBtn)
        
        let deleteBtn = UIButton()
        deleteBtn.frame = CGRect(x: 150, y: 0, width: 50, height: 30)
        deleteBtn.tag = 1002
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.addTarget(self, action: #selector(btnDidTouch(btn:)), for: .touchUpInside)
        footerView.addSubview(deleteBtn)
        
        let cancelBtn = UIButton()
        cancelBtn.frame = CGRect(x: 230, y: 0, width: 50, height: 30)
        cancelBtn.tag = 1003
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(btnDidTouch(btn:)), for: .touchUpInside)
        footerView.addSubview(cancelBtn)
        view.addSubview(footerView)
    }
    //
    func btnDidTouch(btn: UIButton) -> Void {
        if btn.tag == 1000 {
            tableView.isEditing = true
            tableView.allowsMultipleSelectionDuringEditing = true
        }else if btn.tag == 1001 {//selectall
            if tableView.isEditing {
                for num in 0..<dataSource.count {
                    let index = IndexPath.init(row: num, section: 0)
                    tableView.selectRow(at: index, animated: true, scrollPosition: .none)
                }
            }
        }else if btn.tag == 1002{//delete
            //
            let selectArray = tableView.indexPathsForSelectedRows
            let tempArray: NSMutableArray = [""]
            
            if selectArray != nil {
                for num in 0..<selectArray!.count {
                    let index = selectArray?[num]
                    let indexNum = (index?.row)! as Int
                    tempArray.add(dataSource[indexNum])
                }
                for index in 0..<tempArray.count {
                    let obj = tempArray[index]
                    dataSource.remove(obj)
                }
                
            tableView.reloadData()
            }
            
        }else{//cancel
            tableView.isEditing = false
            tableView.allowsMultipleSelectionDuringEditing = false
        }
    }
}

