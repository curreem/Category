//
//  ViewController.swift
//  Categories
//
//  Created by Karim Arhan on 14/04/20.
//  Copyright © 2020 Phincon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     
    enum Mode {
        case view
        case edit
    }

    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    static var delegate: EditButtonDelegate!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "favourite")
        collectionView.register(UINib(nibName: "AllCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allcategory")
        //longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        //collectionView.addGestureRecognizer(longPressGesture)
        setupBarButtonItems()
    }
    
    var editButtonBar: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditButtonPressed(_:)))
        return barButtonItem
    }
    
    var mMode: Mode = .view{
        didSet{
            switch mMode {
            case .view:
                editButtonBar.title = "Edit"
                ViewController.delegate.editMode(mode: false)
            case .edit:
                editButtonBar.title = "Done"
                ViewController.delegate.editMode(mode: true)
            }
        }
    }
    
    var judul = ["Favorit Kamu", "Produk Lain"]
    
    private func setupBarButtonItems(){
        navigationItem.rightBarButtonItem = editButtonBar
    }
    
    @objc func EditButtonPressed(_ sender: UIBarButtonItem){
        mMode = mMode == .view ? .edit : .view
    }

//    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
//        switch(gesture.state) {
//
//        case .began:
//            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
//                break
//            }
//            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
//        case .ended:
//            collectionView.endInteractiveMovement()
//        default:
//            collectionView.cancelInteractiveMovement()
//        }
//    }
    
//    @IBAction func editPressed(_ sender: Any) {
//        if editButton.isSelected == false{
//            editButton.isSelected = true
//            ViewController.delegate.editMode(button: editButton)
//        }else{
//            editButton.isSelected = false
//            ViewController.delegate.editMode(button: editButton)
//        }
//    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return judul.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let item = number.remove(at: sourceIndexPath.item)
//        number.insert(item, at: destinationIndexPath.item)
//        let nama = name.remove(at: sourceIndexPath.item)
//        name.insert(nama, at: destinationIndexPath.item)
//        print(number,name)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favourite", for: indexPath) as! FavouriteCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allcategory", for: indexPath) as! AllCategoryCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        } else{
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
        
//        let width = self.calculateWidth()
//
//        return CGSize(width: width, height: 90)
    }
    
//    func calculateWidth() -> CGFloat {
//        let cellrow = CGFloat(5)
//        let margin = CGFloat(20)
//
//        let width = (self.view.frame.size.width - (margin)) / (cellrow + 1)
//        print(width)
//
//        return width
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView

        section.title.text = judul[indexPath.section]

        return section
    }
    
}

protocol EditButtonDelegate {
    func editMode(mode: Bool)
}
