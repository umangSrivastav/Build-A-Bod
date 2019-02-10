//
//  ViewController.swift
//  Build-A-Bod
//
//  Created by Aditya Ramkumar on 2/9/19.
//  Copyright © 2019 Aditya Ramkumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .yellow;
        
        let imageName = "picberk.png"
        
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        view.addSubview(imageView)
        
        
    }

}

