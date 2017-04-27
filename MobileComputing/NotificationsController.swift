//
//  NotificationsController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notifications"
        
        view.backgroundColor = UIColor.white

        view.addSubview(titleTextLabel)
        setupTitleTextLabel()
    }
    
    var titleTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "This feature is coming soon"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupTitleTextLabel() {
        titleTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
