//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 2/1/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let textFieldDelegate = TextFieldDelegate()
    
    let memeTextFieldAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.text = "TOP"
        topTextField.delegate = textFieldDelegate
        topTextField.defaultTextAttributes = memeTextFieldAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.delegate = textFieldDelegate
        bottomTextField.defaultTextAttributes = memeTextFieldAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //disable camera button if device doesn't have a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //get notified when keyboard is dsiplayed
        subscribeToKeyboardNotifications()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }



    @IBAction func pickAlbum(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
        

    }
    
    @IBAction func pickCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
 
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    //Will call keyboardWillShow when keyboard is displayed and keyboardWillHide when it is removed
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Unsubscribe from notifications about the keyboard getting displayed
    func unsubscribeFromKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Called when the keyboard is about to be displayed
    func keyboardWillShow(notification : NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    //Called when the keyboard is about to be removed
    func keyboardWillHide(notification : NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    //returns the height of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    
    }

}

