//
//  PhotoCollectionViewController.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()
    
    private let insetSize: CGFloat = 10
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        setTheme()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = photoController.photos[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
    
    func setTheme() {
    
        guard let themePreference = themeHelper.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .lightGray
        case "Blue":
            backgroundColor = UIColor(red: 61/255, green: 172/255, blue: 247/255, alpha: 1)
        default:
            break
        }
        
        collectionView?.backgroundColor = backgroundColor
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "SelectTheme":
            
            guard let destinationVC = segue.destination as? ThemeSelectionViewController else { return }
            
            destinationVC.themeHelper = themeHelper
            destinationVC.collectionVC = self
            
        case "CreatePhoto":
            
            guard let destinationVC = segue.destination as? PhotoDetailViewController else { return }
            
            destinationVC.photoController = photoController
            destinationVC.themeHelper = themeHelper
            
        case "ViewPhoto":
            
            guard let destinationVC = segue.destination as? PhotoDetailViewController,
                let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.photo = photoController.photos[indexPath.row]
            destinationVC.photoController = photoController
            destinationVC.themeHelper = themeHelper
            
        default:
            break
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetSize, left: insetSize, bottom: insetSize, right: insetSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insetSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = view.bounds.width
        let cellWidth = (screenWidth / 2) - (insetSize * 2)
        let cellHeight = cellWidth + 20

        return CGSize(width: cellWidth, height: cellHeight)
    }

    // this is the thing I wasn't sure about! It wasn't in the instructions but it makes it work how I want it to, and it wasn't working how I expected without it, so ¯\_(ツ)_/¯
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insetSize * 2
    }
}
