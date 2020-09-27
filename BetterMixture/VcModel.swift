//
//  VcModel.swift
//  BetterMixture
//
//  Created by 石博 on 2020/9/25.
//  Copyright © 2020 石博. All rights reserved.
//

import Foundation
import UIKit
class VcModel: NSObject, CollectionLayoutProtocol {
    var unsureimage: UIImage?
    var textData: [String]?
    var unsureNumber: Int = 0

    lazy var collectionView: UICollectionView = {
        let layout = CollectionLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.delegate = self
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: "PictureCell")
        collectionView.register(UnsureCell.self, forCellWithReuseIdentifier: "UnsureCell")
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    override init() {
        super.init()
        let jsonPath = Bundle.main.path(forResource: "vcdata", ofType: "json")
        let data = NSData.init(contentsOfFile: jsonPath!)
        let jsonDic: NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        self.unsureimage = UIImage(named: jsonDic["unsureImage"] as! String)
        self.unsureNumber = jsonDic["unsurenumber"] as! Int
        self.textData = jsonDic["text"] as? [String]
        self.collectionView.reloadData()

    }

    func secondCell(cell: UnsureCell, indexPath: IndexPath) {
        cell.pictureView.image = unsureimage
        let size = self.collectionView.layoutAttributesForItem(at: indexPath)!.frame.size
        cell.pictureView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    func thirdCell(cell: TextCell, indexPath: IndexPath) {
        cell.textView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 12, height: self.getHeight(withLabelText: textData![indexPath.row], width: UIScreen.main.bounds.width-12, font: UIFont.init(name: "Georgia", size: 30)!))
        cell.textView.text = textData![indexPath.item]
        cell.textView.font = UIFont.init(name: "Georgia", size: 30)
        cell.textView.numberOfLines = 0
        cell.contentView.layer.addSublayer(self.getCicleAngle(bound: cell.contentView.bounds))

    }

    func getCicleAngle(bound: CGRect) -> CAShapeLayer {
        let path = UIBezierPath.init(roundedRect: bound, byRoundingCorners: [.topRight, .bottomRight, .topLeft, .bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.lineWidth = 1
        layer.lineCap = CAShapeLayerLineCap.square
        layer.strokeColor = UIColor.gray.cgColor
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        layer.fillColor = color
        return layer
    }
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
      if indexPath.section == 0 {
          return (UIScreen.main.bounds.width-2.0*6)*2/3
      }
      if indexPath.section == 1 {

            if unsureNumber < 5 {
                return UIScreen.main.bounds.width/CGFloat(unsureNumber)
            } else {return UIScreen.main.bounds.width/5.0}

      }
      if indexPath.section == 2 {

            return self.getHeight(withLabelText: textData![indexPath.row], width: UIScreen.main.bounds.width-12, font: UIFont.init(name: "Georgia", size: 30)!)

      }
      return 180
    }
    func Column(
          _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath: IndexPath) -> Int {
      if indexPath.section == 0 || indexPath.section == 2 {
          return 1
      }
      if indexPath.section == 1 {
        if unsureNumber<5 {
            return unsureNumber
        } else {return 5}

      }
      return 0
    }
    func getHeight(withLabelText text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension UIImage {
    func reSizeImage(reSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
}
