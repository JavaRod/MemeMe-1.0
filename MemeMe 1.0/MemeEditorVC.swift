//
//  MemeEditorVC.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 2/1/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    let textFieldDelegate = TextFieldDelegate()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure meme text fields
        prepareTextField(topTextField, defaultText: "TOP")
        prepareTextField(bottomTextField, defaultText: "BOTTOM")
    
        
        //disable share button
        shareButton.enabled = false;
    
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
    
    //Common method to set meme text field properties
    func prepareTextField(textField: UITextField, defaultText: String) {
        let memeTextFieldAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        textField.text = defaultText
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextFieldAttributes
        textField.textAlignment = NSTextAlignment.Center
        
    }


    //Present view to pick from photo album
    @IBAction func pickAlbum(sender: AnyObject) {
        
        presentViewForType(UIImagePickerControllerSourceType.PhotoLibrary)

    }
    
    //Present view to pick from a camera
    @IBAction func pickCamera(sender: AnyObject) {
        
        presentViewForType(UIImagePickerControllerSourceType.Camera)
    }
    
    //Present view for specified type
    func presentViewForType(type: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        shareButton.enabled = true;
        
    }
    
 
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
        //Only move if bottom text field is selected 
        if (bottomTextField.isFirstResponder()) {
          view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    //Called when the keyboard is about to be removed
    func keyboardWillHide(notification : NSNotification) {
        view.frame.origin.y = 0
    }
    
    //returns the height of the keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    
    }
    
    //Create Meme object
    func save() {
        
        let meme : Meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: generatedMemedImage())
        
    }
    
    func generatedMemedImage() -> UIImage {
    
        navigationBar.hidden = true
        toolbar.hidden = true

        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationBar.hidden = false
        toolbar.hidden = false
 
        
        return memedImage
    }

    @IBAction func shareMeme(sender: AnyObject) {
        
        let memeImage : UIImage = generatedMemedImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems:[AnyObject]?, error:NSError?) in
            if (completed) {
             self.save()
            }
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(controller, animated: true, completion: nil)
        
    }
}



