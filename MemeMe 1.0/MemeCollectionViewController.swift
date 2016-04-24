//
//  MemeCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 4/19/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        adjustFlowLayout(self.view.frame.size)
    }
    
    //Code from discussion board: https://discussions.udacity.com/t/mememe-collectionview-flow-layout/39382
    func adjustFlowLayout(size: CGSize) {
        let space: CGFloat = 1.5
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeCollectionView.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getAllMemes().count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = getAllMemes()[indexPath.item]
        let image = meme.memedImage
        cell.memeImageView!.image = image
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = getAllMemes()[indexPath.row]
        
        var editButton = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: detailController,
            action: "editMeme:"
        )
        
        detailController.navigationItem.setRightBarButtonItem(editButton, animated: true)
        self.parentViewController!.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    func getAllMemes() -> [Meme] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
    
}
