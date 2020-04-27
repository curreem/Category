//
//  FavouriteCollectionViewCell.swift
//  Categories
//
//  Created by Karim Arhan on 16/04/20.
//  Copyright © 2020 Phincon. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    
    static var delegate: FavouriteDelegate!
    var favourites: [Favourite] = [Favourite]()
    
    @IBOutlet weak var FavouriteCell: UICollectionView! {
        didSet{
            FavouriteCell.delegate = self
            FavouriteCell.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FavouriteCell.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "items")
        AllCategoryCollectionViewCell.delegate = self
        ViewController.delegate = self
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        FavouriteCell.addGestureRecognizer(longPressGesture)
    }
    
    var Edit: Bool = false
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
            switch(gesture.state) {
    
            case .began:
                guard let selectedIndexPath = FavouriteCell.indexPathForItem(at: gesture.location(in: FavouriteCell)) else {
                    break
                }
                FavouriteCell.beginInteractiveMovementForItem(at: selectedIndexPath)
            case .changed:
                FavouriteCell.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            case .ended:
                FavouriteCell.endInteractiveMovement()
            default:
                FavouriteCell.cancelInteractiveMovement()
            }
        }
}

extension FavouriteCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate,CategoryDelegate, EditButtonDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "items", for: indexPath) as! ItemCollectionViewCell
        
        cell.name.text = favourites[indexPath.row].name
        cell.number.text = favourites[indexPath.row].number
        
        DispatchQueue.main.async {
            if self.Edit == true{
                cell.circle.isHidden = false
                print("showFC")
            }
        }
        DispatchQueue.main.async{
            if self.Edit == false {
                cell.circle.isHidden = true
                print("hideFC")
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

        let width = (UIScreen.main.bounds.width - (margin)) / (cellrow + 1)
        print(width)

        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if self.Edit == true{
                FavouriteCollectionViewCell.delegate.sendFavourite(name: self.favourites[indexPath.item].name, number: self.favourites[indexPath.item].number)
                self.favourites.remove(at: indexPath.item)
                self.FavouriteCell.deleteItems(at: [indexPath])
            }
        }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let item = favourites.remove(at: sourceIndexPath.item)
            favourites.insert(item, at: destinationIndexPath.item)
        }
    
    func sendCategory(name: String, number: String) {
        favourites.append(Favourite(name: name, number: number))
        self.FavouriteCell.reloadData()
    }
    
    func editMode(mode: Bool) {
        Edit = mode
    }
    
}
struct Favourite {
    var name:String
    var number:String
}

protocol FavouriteDelegate{
    func sendFavourite(name: String, number: String)
}
