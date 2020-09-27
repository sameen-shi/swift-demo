//
//  PictureCell.swift
//  BetterMixture
//
//  Created by 石博 on 2020/9/25.
//  Copyright © 2020 石博. All rights reserved.
//

import Foundation
import UIKit
class PictureCell: UICollectionViewCell {
    var model = PictureCellModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(model.cycleCollectionView!)
        self.contentView.addSubview(model.pageControl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.model.addTimer()
        }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.model.removeTimer()
    }

//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        pageControl.numberOfPages = pictureData.count
//        return pictureData.count
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (Int(scrollView.contentOffset.x) / Int(UIScreen.main.bounds.width-12)) % model.pictureData.count
        model.pageControl.currentPage = page
    }
}
