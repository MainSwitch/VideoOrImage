//
//  PreviewVCViewController.swift
//  VideoOrImage
//
//  Created by Anton on 03.06.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class PreviewVCViewController: UIViewController {
    @IBOutlet private weak var imageViewPreview: UIImageView!
    
    
    
    var currentPhoto: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //imageViewPreview.frame = CGRect(x: 0, y: 64, width: 375, height: 603)
        self.imageViewPreview.image = currentPhoto;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
