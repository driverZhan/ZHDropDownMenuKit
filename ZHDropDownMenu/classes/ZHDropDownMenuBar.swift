//
//  ZFDropDownMenuBar.swift
//  ZHDropDownMenu
//
//  Created by  monstar on 2019/8/12.
//  Copyright © 2019 zhany. All rights reserved.
//

import UIKit

fileprivate let ITEM_DEFAULT_MARGIN: CGFloat = 1

class ZHDropDownMenuBar: UIView {
    
    
    var showSubListBlock: ((_ item: ZHDropMenuItem) -> Void)?
    
    private var activeCell: ZHDropMenuItemCell!
    
    var config: ZHDropDownMenuConfig!
    var itemCountPerPage: CGFloat = 3
    
    var items: [ZHDropMenuItem] = [ZHDropMenuItem]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var cells: [ZHDropMenuItemCell] = [ZHDropMenuItemCell]()
    
    
    lazy var layout: UICollectionViewFlowLayout = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        
        lay.minimumLineSpacing = ITEM_DEFAULT_MARGIN
        lay.minimumInteritemSpacing = ITEM_DEFAULT_MARGIN
        return lay
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(ZHDropMenuItemCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(collectionView.superview == nil) {
            addSubview(collectionView)
        }
        
        collectionView.frame = self.bounds
        let width = (self.bounds.width - (itemCountPerPage - 1)) / 3
        layout.itemSize = CGSize(width: width, height: self.bounds.height)
        
    }
}

extension ZHDropDownMenuBar: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cells.count > indexPath.row {
           let cell = cells[indexPath.row]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ZHDropMenuItemCell
            cell.contentView.backgroundColor = UIColor.brown
            let item = items[indexPath.row]
            cell.item = item
            cell.actionBlock = { (item,cell) in
                if self.activeCell == nil || cell == self.activeCell {
                    cell.actionButton.isSelected = !cell.actionButton.isSelected
                    self.activeCell = cell
                }else {
                    if self.activeCell.actionButton.isSelected {
                        return
                    }
                    cell.actionButton.isSelected = !cell.actionButton.isSelected
                    self.activeCell = cell
                }
                
                //显示菜单
                self.showSubListBlock?(item)
            }
            return cell
        }
    }
    
}


class ZHDropMenuItemCell: UICollectionViewCell {
    
    
    var actionBlock: ((_ item: ZHDropMenuItem,_ cell: ZHDropMenuItemCell) -> Void)?
    
    var item: ZHDropMenuItem! {
        didSet {
            actionButton.setTitle(item.title, for: .normal)
            actionButton.setTitle(item.title, for: .selected)
        }
    }
    
    var showItem: ZHDropMenuItem! {
        didSet {
            actionButton.setTitle(showItem.title, for: .normal)
            actionButton.setTitle(showItem.title, for: .selected)
        }
    }
    
    lazy var actionButton: UIButton = {
        let label = UIButton(type: .custom)
        label.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        label.setTitleColor(UIColor.black, for: .normal)
        label.setTitleColor(UIColor.red, for: .selected)
        label.setImage(UIImage(named: ""), for: .normal)
        label.setImage(UIImage(named: ""), for: .selected)
        label.addTarget(self, action: #selector(actionBtnClicked(sender:)), for: .touchUpInside)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actionButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    @objc private func actionBtnClicked(sender: UIButton) {
        actionBlock?(item,self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.sizeToFit()
        actionButton.center = self.contentView.center
        
    }
}
