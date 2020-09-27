//
//  UnsureCell.swift
//  BetterMixture
//
//  Created by 石博 on 2020/9/25.
//  Copyright © 2020 石博. All rights reserved.
//

import Foundation
import UIKit
class UnsureCell: UICollectionViewCell {
    var pictureView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        pictureView = UIImageView()
        self.contentView.addSubview(pictureView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
