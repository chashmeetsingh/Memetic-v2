//
//  TableViewController.swift
//  Mematic-v2
//
//  Created by Y50-70 on 09/09/16.
//  Copyright © 2016 Chashmeet Singh. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var memes: [Meme] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setDLAndDS()
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getMemes()
        tableView.reloadData()
    }

    func getMemes() {
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    func setDLAndDS() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

extension TableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailView", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailView" {
            let vc = segue.destinationViewController as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            vc.memeImage = memes[indexPath!.row].memedImage
        }
    }

}

extension TableViewController: UITableViewDataSource {

    func items() -> [Meme] {
        return memes
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items().count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
        let item = items()[indexPath.row]

        cell.textLabel?.textAlignment = .Center
        cell.textLabel!.text = item.text

        cell.imageView!.image = item.memedImage

        return cell
    }

}