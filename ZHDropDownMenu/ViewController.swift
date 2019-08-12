//
//  ViewController.swift
//  ZHDropDownMenu
//
//  Created by  monstar on 2019/8/12.
//  Copyright © 2019 zhany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var items: [ZHDropMenuItem] = [ZHDropMenuItem]()
        for i in 1...5 {
            let item = ZHDropMenuItem()
            item.title = "一级菜单-\(i)"
            item.subItems = [ZHDropMenuItem]()
            for j in 1...6 {
                let subItem = ZHDropMenuItem()
                subItem.subItems = [ZHDropMenuItem]()
                subItem.title = "二级菜单-\(i)-\(j)"
                
                for m in 1...6 {
                    let temp = ZHDropMenuItem()
                    temp.title = "三级菜单-\(j)-\(m)"
                    subItem.subItems?.append(temp)
                }
                
                item.subItems?.append(subItem)
            }
            items.append(item)
        }
        
        let menu = ZHDropDownMenuView(menuItems: items)
        view.addSubview(menu)
    }


}

