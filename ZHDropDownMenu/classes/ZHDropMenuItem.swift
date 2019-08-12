//
//  ZFDropMenuItem.swift
//  ZHDropDownMenu
//
//  Created by  monstar on 2019/8/12.
//  Copyright © 2019 zhany. All rights reserved.
//

import UIKit

open class ZHDropMenuItem: NSObject {
    open var title: String = ""
    open var subItems: [ZHDropMenuItem]?
    open var userInfo: Any?
    var isHaveSubMenu: Bool {
        get {
            
            guard let sublist = subItems else {
                return false
            }
            return sublist.count > 0
        }
    }
}
