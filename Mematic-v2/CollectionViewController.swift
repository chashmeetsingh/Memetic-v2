//
//  CollectionViewController.swift
//  Mematic-v2
//
//  Created by Y50-70 on 09/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var memes: [Meme] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setDLAndDS()
        self.view.backgroundColor = UIColor.whiteColor()

        let space: CGFloat
        let dimension: CGFloat

        if (UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            space = 3.0
            dimension = (view.frame.size.width - (2 * space)) / 3 //3 per line
        } else {
            space = 5.0
            dimension = (view.frame.size.width - (2 * space)) / 5
        }

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getMemes()
        collectionView.reloadData()
    }

    func getMemes() {
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    func setDLAndDS() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

}

extension CollectionViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailView", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailView" {
            let vc = segue.destinationViewController as! DetailViewController
            let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
            vc.memeImage = memes[indexPath.row].memedImage
        }
    }

}

extension CollectionViewController: UICollectionViewDataSource {

    func items() -> [Meme] {
        return memes
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items().count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CollectionViewCell
        let item = items()[indexPath.row].memedImage

        cell.memeImageView.image = item


        return cell
    }

}