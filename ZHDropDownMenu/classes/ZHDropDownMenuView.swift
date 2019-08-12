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


class ZHDropDownMenuView: UIView {
    open var menuBarHeight: CGFloat = MENU_DEFAULT_BAR_HEIGTH
    open var items: [ZHDropMenuItem]? {
        didSet {
            guard let datas = items else {return}
            menuBar.items = datas
        }
    }
    
    lazy private var menuBar: ZHDropDownMenuBar = {
        let bar = ZHDropDownMenuBar(frame: CGRect(x: 0, y: 0, width: MENU_DEFAULT_WIDTH, height: MENU_DEFAULT_BAR_HEIGTH))
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuBar.frame = self.bounds;
    }
    
    
}
