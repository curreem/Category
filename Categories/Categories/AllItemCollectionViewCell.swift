//
//  AllItemCollectionViewCell.swift
//  Categories
//
//  Created by Karim Arhan on 16/04/20.
//  Copyright © 2020 Phincon. All rights reserved.
//

import UIKit

class AllItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nama: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var circle: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        circle.makeCircular()
    }

}
