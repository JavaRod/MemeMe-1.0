//
//  TextFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 2/6/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation
import UIKit


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.text == "TOP" || textField.text == "BOTTOM"){
        textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true;
    }
        
    
}