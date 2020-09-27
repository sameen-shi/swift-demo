//
//  ViewController.swift
//  BetterMixture
//
//  Created by 石博 on 2020/9/25.
//  Copyright © 2020 石博. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var data: VcModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        data = VcModel()
        view.addSubview(data!.collectionView)
        data!.collectionView.delegate = self
        data!.collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {

            return data!.unsureNumber > 5 ? (data!.unsureNumber/5)*5 : data!.unsureNumber
        }
        if section == 2 {
            return 4
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as!PictureCell
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsureCell", for: indexPath) as!UnsureCell
            data!.secondCell(cell: cell, indexPath: indexPath)
            return cell
        }
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as!TextCell
            data!.thirdCell(cell: cell, indexPath: indexPath)
            return cell
        }
        let cells: UICollectionViewCell = UICollectionViewCell()
        return cells
    }

}
