//
//  MemeDetailViewController.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 4/18/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memeImageView?.image = meme.memedImage

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let memeEditorNavController = segue.destinationViewController as! UINavigationController
        let memeEditorViewController = memeEditorNavController.viewControllers[0] as! MemeEditorVC
        memeEditorViewController.existingMeme = meme
    }
    
    func editMeme(sender: UIBarButtonItem) {
        
        //let controller = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorVC
        
        performSegueWithIdentifier("editMeme", sender: self)
        //controller.existingMeme = meme
        //self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
}
