//
//  AppDelegate.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/5/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
//        let tabBarController = UITabBarController()
//        
//        let tabViewController1 = HomeController()
//        let tabViewController2 = MessagesController()
//        let tabViewController3 = NewListingController()
//        let tabViewController4 = NotificationsController()
//        let tabViewController5 = UserProfileController()
//        
//        tabViewController1.tabBarItem = UITabBarItem(
//            title: "Home",
//            image: UIImage(named: "home"),
//            tag: 1)
//        tabViewController2.tabBarItem = UITabBarItem(
//            title: "Messages",
//            image:UIImage(named: "messages") ,
//            tag:2)
//        tabViewController3.tabBarItem = UITabBarItem(
//            title: "Sell",
//            image:UIImage(named: "sell") ,
//            tag:2)
//        tabViewController4.tabBarItem = UITabBarItem(
//            title: "Notifications",
//            image:UIImage(named: "notifications") ,
//            tag:2)
//        tabViewController5.tabBarItem = UITabBarItem(
//            title: "User",
//            image:UIImage(named: "profile") ,
//            tag:2)
//        
//        let controllers = [tabViewController1, tabViewController2, tabViewController3, tabViewController4, tabViewController5]
//        tabBarController.viewControllers = controllers
//        window?.rootViewController = tabBarController
        
        window?.rootViewController = UINavigationController(rootViewController: HomeController())
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

