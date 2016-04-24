//
//  SentMemeTableViewController.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 4/5/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memeTableView: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAllMemes().count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = getAllMemes()[indexPath.row]
        let topAndBottom = meme.topText as String + " " + (meme.bottomText as String)
        // Set the name and image
        cell.MemeLabel?.text = topAndBottom
        cell.MemeImageView?.image = meme.memedImage
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            appDelegate.deleteMeme(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func getAllMemes() -> [Meme] {
        return appDelegate.memes
    }
    
}

