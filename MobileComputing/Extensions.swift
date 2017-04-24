//
//  Extensions.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/23/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
    
        // check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = (cachedImage as! UIImage)
            return
        }
        
        // otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            // download hit an error so let's return out
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
                
                
                
            }
        }).resume()
    }
    
}
