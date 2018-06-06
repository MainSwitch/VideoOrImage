//
//  MyCell.swift
//  VideoOrImage
//
//  Created by Anton on 01.06.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    @IBOutlet weak var FindImage: UIImageView!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    private var downloadTask: URLSessionDownloadTask?
    let imageCache = NSCache<AnyObject, AnyObject>.sharedInstance
    
    var imageURL: URL?{
    didSet {
    FindImage?.image = nil
        updateUI()
        }
    }

    private func updateUI(){
        print("Этот URL ->>>\(imageURL!)")
        
        if let url = imageURL{
            if let cahedimage = imageCache.object(forKey: url.absoluteString as NSString){
                self.FindImage!.image = cahedimage as? UIImage
            }else{
            Spinner.isHidden = false
            Spinner?.startAnimating()
            DispatchQueue.global(qos:.userInitiated).async{
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL{
                        if let imageData = contentsOfURL{
                            let imageToCache = UIImage(data: imageData)
                            if let imageView = self.FindImage{
                            imageView.image = imageToCache
                                self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString, cost: 1)
                            //self.FindImage.image = UIImage(data: imageData)
                            }
                        }
                        self.Spinner.stopAnimating()
                        self.Spinner.isHidden = true
                        }
                    }
                }
            }
        }
    }
}
extension NSCache{
  @objc class var sharedInstance: NSCache<NSString, AnyObject> {
        let cache = NSCache<NSString, AnyObject>()
        return cache
    }
}
