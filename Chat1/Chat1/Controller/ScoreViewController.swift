//
//  ScoreViewController.swift
//  Chat1
//
//  Created by Micah Yong on 2/10/19.
//  Copyright © 2019 Micah Yong. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "body")
        let imageView = UIImageView(image: image!)
        // this enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hi! Welcome to Build-A-Bod. Challenge a friend to a fitness battle!"
        textView.font = UIFont.boldSystemFont(ofSize: 28)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let pointsTextView: UITextView = {
        let textView = UITextView()
        textView.text = "You currently have 0 points."
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ok!", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(logoImageView)
        view.addSubview(descriptionTextView)
        view.addSubview(pointsTextView)
        self.view.backgroundColor = UIColor(r: 255, g: 140, b: 0)
        
        setupLayout()
    }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout() {
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        pointsTextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30).isActive = true
        pointsTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pointsTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pointsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}

