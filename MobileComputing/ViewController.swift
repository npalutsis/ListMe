//
//  LoginController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/5/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleLogout))
    }
    
    func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}
