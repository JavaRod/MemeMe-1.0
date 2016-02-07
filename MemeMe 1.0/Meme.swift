//
//  Meme.swift
//  MemeMe 1.0
//
//  Created by Rodrick Musser on 2/6/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation
import UIKit


class Meme: NSObject {
    
    var topText : NSString!
    var bottomText: NSString!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(topText: NSString, bottomText: NSString, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image;
        self.memedImage = memedImage;
        
    }
    
    
    
}