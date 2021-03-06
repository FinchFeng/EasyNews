//
//  GirlsCollectionView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

protocol GirlCollectionProtocol {
    func needAdd()
    func cellSelector(girlModel: GirlModel, mframe: CGRect)
}

class GirlsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    var girl_delegate: GirlCollectionProtocol?
    
    var models: [GirlModel] = [] {
        didSet{
            self.reloadData()
        }
    }
    
    init(frame: CGRect) {
        let mlayout = UICollectionViewFlowLayout()
        width = SCREEN_WIDTH / 3.0 - 4.5 // 4.5是 3 + 1.5
        height = width /// 2 * 3
        mlayout.itemSize = CGSize(width: width, height: height)                   // 每个Item的大小
        mlayout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) // 设置每组的cell的边界 距离屏幕的上下左右位置
        mlayout.minimumLineSpacing = 3      // cell的最小行间距
        mlayout.minimumInteritemSpacing = 3 // cell的最小列间距
        super.init(frame: frame, collectionViewLayout: mlayout)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        
        self.delegate = self
        self.dataSource = self
        
        self.register(GirlCollectionViewCell.self, forCellWithReuseIdentifier: "GirlCollectionViewCell")
    }
    
    //返回section个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 每个section的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = GirlCollectionViewCell.cellWith(collectionView: collectionView, indexPath: indexPath, width: width, height: height)
        
        cell.setImageURL(url: NetTool.tiangou_image_base_url + models[indexPath.row].img + "_" + (width * 1.5).toStringValue + "x" + (height * 1.5).toStringValue)
        
//        if cell.imageView.image == nil {
//            cell.canDismiss = false
//        }else {
//            cell.canDismiss = true
//        }
        
        return cell
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    // cell被选择时被调用
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        var mframe: CGRect!
        if cell != nil {
            mframe = cell?.frame
        }else {
            mframe = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        girl_delegate?.cellSelector(girlModel: models[indexPath.row], mframe: mframe)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentSize.height < frame.size.height {
            if scrollView.contentOffset.y > 20 {
                //print("cool")
            }
        }else {
            if (scrollView.contentSize.height - frame.size.height - frame.size.height / 3 < scrollView.contentOffset.y) {
                girl_delegate?.needAdd()
            }
        }
    }
    
    private func showFooterview() -> Void {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
