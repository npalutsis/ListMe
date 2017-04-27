//
//  TabBarController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/15/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup our custom view controllers
//        let layout = UICollectionViewFlowLayout()
        
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem.title = "Home"
        homeController.tabBarItem.image = UIImage(named: "home")
        
        let messagesController = UINavigationController(rootViewController: MessagesController())
        messagesController.tabBarItem.title = "Messages"
        messagesController.tabBarItem.image = UIImage(named: "messages")
        
        let newListingController = UINavigationController(rootViewController: NewListingController())
        newListingController.tabBarItem.title = "Sell"
        newListingController.tabBarItem.image = UIImage(named: "sell")
        
        let notificationsController = UINavigationController(rootViewController: NotificationsController())
        notificationsController.tabBarItem.title = "Notifications"
        notificationsController.tabBarItem.image = UIImage(named: "notifications")
        
        let userProfileController = UINavigationController(rootViewController: UserProfileController())
        userProfileController.tabBarItem.title = "User"
        userProfileController.tabBarItem.image = UIImage(named: "profile")
        
        viewControllers = [homeController, messagesController, newListingController, notificationsController, userProfileController]
    }
    
    private func createDummyNavControllerWithTitle(_ title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
}
