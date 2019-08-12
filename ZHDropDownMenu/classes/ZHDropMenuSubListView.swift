//
//  ZHDropMenuSubListView.swift
//  ZHDropDownMenu
//
//  Created by zhany on 2019/8/12.
//  Copyright © 2019 zhany. All rights reserved.
//

import UIKit

class ZHDropMenuSubListView: UIView {

    
    var items: [ZHDropMenuItem] = [ZHDropMenuItem]() {
        didSet {
            guard items.count > 0 else {return}
            currentItem = items.first
        }
    }
    
    var currentItem: ZHDropMenuItem! {
        didSet {
            rightTableView.reloadData()
        }
    }
    
    func loadData(menus: [ZHDropMenuItem]) {
        items = menus
        self.leftTableView.reloadData()
        self.leftTableView.tableFooterView = UIView()
        self.rightTableView.tableFooterView = UIView()
    }
    
    lazy var leftTableView: UITableView = {
        let tabel = UITableView()
        tabel.delegate = self
        tabel.dataSource = self
        tabel.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "left")
        return tabel
        
    }()
    
    lazy var rightTableView: UITableView = {
        let tabel = UITableView()
        tabel.delegate = self
        tabel.dataSource = self
        tabel.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "right")
        return tabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(leftTableView)
        self.addSubview(rightTableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.bounds.width
        leftTableView.frame = CGRect(x: 0, y: 0, width: (width * 0.4), height: self.bounds.height)
        rightTableView.frame = CGRect(x: (width * 0.4), y: 0, width: (width * 0.6), height: self.bounds.height)
    }
    
}

extension ZHDropMenuSubListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return items.count
        }else {
            guard currentItem != nil else {return 0}
            guard let subMenus = currentItem.subItems else {return 0}
            return subMenus.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "left", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            let item = items[indexPath.row]
            cell.textLabel?.text = item.title
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "right", for: indexPath)
            guard let subMenus = currentItem.subItems else {return cell}
            let item = subMenus[indexPath.row]
            cell.textLabel?.text = item.title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        if tableView == leftTableView {
            let item = items[indexPath.row]
            currentItem = item
        }
        
    }
}
