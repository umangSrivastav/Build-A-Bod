//
//  Extentions.swift
//  Chat1
//
//  Created by Micah Yong on 1/15/19.
//  Copyright © 2019 Micah Yong. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise, fire off new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
            
            // download hit an error
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
