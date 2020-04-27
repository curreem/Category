//
//  AllCategoryCollectionViewCell.swift
//  Categories
//
//  Created by Karim Arhan on 16/04/20.
//  Copyright © 2020 Phincon. All rights reserved.
//

import UIKit

class AllCategoryCollectionViewCell: UICollectionViewCell {
    
    var categories = ListofCategory.construct()
    static var delegate: CategoryDelegate!

    @IBOutlet weak var AllItem: UICollectionView! {
        didSet{
            AllItem.delegate = self
            AllItem.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        AllItem.register(UINib(nibName: "AllItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allitem")
        FavouriteCollectionViewCell.delegate = self
        ViewController.delegate = self
    }
    
    var Edit:Bool!

}

extension AllCategoryCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, FavouriteDelegate, EditButtonDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allitem", for: indexPath) as! AllItemCollectionViewCell
        
        cell.nama.text = categories[indexPath.row].name
        cell.item.text = categories[indexPath.row].number
        DispatchQueue.main.async {
            if self.Edit == true{
                cell.circle.isHidden = false
            }
        }
        DispatchQueue.main.async{
            if self.Edit == false {
                cell.circle.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()

        return CGSize(width: width, height: 90)
    }
    
    func calculateWidth() -> CGFloat {
        
        let cellrow = CGFloat(5)
        let margin = CGFloat(20)

        let width = (self.AllItem.frame.size.width - (margin)) / (cellrow + 1)
        print(width)

        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Edit == true{
            AllCategoryCollectionViewCell.delegate.sendCategory(name: categories[indexPath.item].name, number: categories[indexPath.item].number)
            categories.remove(at: indexPath.item)
            self.AllItem.deleteItems(at: [indexPath])
        }
        
        
    }
    
    func sendFavourite(name: String, number: String) {
        categories.append(Category(name: name, number: number))
        self.AllItem.reloadData()
    }
    
    func editMode(mode: Bool) {
       Edit = mode
    }

}

struct Category {
    var name: String
    var number:String
}

class ListofCategory{
    static func construct() -> [Category]{
        let temp: [Category] = [
            Category(name: "Makanan & Minuman", number: "1"),
            Category(name: "Telco", number: "2"),
            Category(name: "Kesehatan & Kecantikan", number: "3"),
            Category(name: "Travel", number: "4"),
            Category(name: "Fashion", number: "5"),
            Category(name: "Olahraga & edukasi", number: "6"),
            Category(name: "Hiburan", number: "7"),
            Category(name: "Donasi", number: "8"),
            Category(name: "Kupon Undian", number: "9"),
            Category(name: "Netflix", number: "10"),
            Category(name: "Electronic", number: "11"),
            Category(name: "Music", number: "12")
        ]
        return temp
    }
}

protocol CategoryDelegate {
    func sendCategory(name: String, number: String)
}
