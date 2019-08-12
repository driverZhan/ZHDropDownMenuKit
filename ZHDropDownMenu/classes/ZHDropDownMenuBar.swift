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
    
    var itemCountPerPage: CGFloat = 3
    
    var items: [ZHDropMenuItem] = [ZHDropMenuItem]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ZHDropMenuItemCell
        cell.contentView.backgroundColor = UIColor.brown
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        return cell
    }
    
    
    
}


class ZHDropMenuItemCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
        
    }
}
