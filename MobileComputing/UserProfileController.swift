//
//  UserProfileController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "User Profile"
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(profileImageView)
        setupProfileImageView()
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileScreen")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    func setupProfileImageView() {
        // need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -80).isActive = true
    }
}
