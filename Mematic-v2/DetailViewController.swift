//
//  DetailViewController.swift
//  Mematic-v2
//
//  Created by Y50-70 on 09/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memeImage: UIImage!
    @IBOutlet weak var memeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setImage()
    }

    func setImage() {
        memeImageView.image = memeImage
    }

}
