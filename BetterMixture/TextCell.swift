//
//  TextCell.swift
//  BetterMixture
//
//  Created by 石博 on 2020/9/25.
//  Copyright © 2020 石博. All rights reserved.
//

import Foundation
import UIKit

class TextCell: UICollectionViewCell {
    var textView: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        textView = UILabel()
        self.contentView.addSubview(textView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
