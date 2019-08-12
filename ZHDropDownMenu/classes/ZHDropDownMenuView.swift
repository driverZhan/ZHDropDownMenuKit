//
//  ZFDropDownMenuView.swift
//  ZHDropDownMenu
//
//  Created by  monstar on 2019/8/12.
//  Copyright © 2019 zhany. All rights reserved.
//

import UIKit

fileprivate let MENU_DEFAULT_BAR_HEIGTH: CGFloat = 50
fileprivate let MENU_DEFAULT_HEIGHT: CGFloat = UIScreen.main.bounds.height
fileprivate let MENU_DEFAULT_WIDTH: CGFloat = UIScreen.main.bounds.width


enum ZHDropDownMenuStyle: Int {
    case list = 0
    case subList = 1
}

class ZHDropDownMenuView: UIView {
    open var config: ZHDropDownMenuConfig!
    
    open var menuBarHeight: CGFloat = MENU_DEFAULT_BAR_HEIGTH
    open var items: [ZHDropMenuItem]? {
        didSet {
            guard let datas = items else {return}
            menuBar.items = datas
        }
    }
    
    lazy private var menuBar: ZHDropDownMenuBar = {
        let bar = ZHDropDownMenuBar(frame: CGRect(x: 0, y: 0, width: MENU_DEFAULT_WIDTH, height: MENU_DEFAULT_BAR_HEIGTH))
        bar.showSubListBlock = { (item) in
            self.showMenus(item: item)
        }
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(menuItems: [ZHDropMenuItem], menuBarHeight: CGFloat = MENU_DEFAULT_BAR_HEIGTH) {
        let frame = CGRect(x: 0, y: 100, width: MENU_DEFAULT_WIDTH, height:menuBarHeight)
        super.init(frame: frame)
        items = menuItems
        initUI()
        menuBar.items = menuItems
    }
    
    private func initUI() {
        addSubview(menuBar)
    }
    
    
    private func showMenus(item: ZHDropMenuItem) {
        
        guard let menus = item.subItems else {
            return
        }
        
        let style: ZHDropDownMenuStyle = fetchMenuStyle(menus: menus)
        
        let frame = self.frame
        let subMenuFrame = CGRect(x: self.bounds.minX, y: frame.maxY, width: frame.width, height: UIScreen.main.bounds.height - frame.maxY)
        
        if style == .subList {
            let listView = ZHDropMenuSubListView(frame: subMenuFrame)
            self.superview?.addSubview(listView)
            listView.loadData(menus: menus)
        }
        
        
    }
    
    private func fetchMenuStyle(menus: [ZHDropMenuItem]) -> ZHDropDownMenuStyle {
        var style: ZHDropDownMenuStyle = .list
        //判断二级菜单下是否有3级菜单
        for temp in menus {
            if temp.isHaveSubMenu {
                style = .subList
                break
            }
        }
        return style
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuBar.frame = self.bounds;
    }
    
    
}
