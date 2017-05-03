//
//  ListingPageController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/29/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

class ListingPageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarLogo()
        fetchUser()
        
//        view.alwaysBounceVertical = true
        view.backgroundColor = UIColor.white
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(handleClear))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: #selector(handleBuy))
//        navigationItem.title = "New Listing"
        
        
        view.addSubview(listingScrollView)
        setupScrollView()
        
//        view.addSubview(titleTextLabel)
//        view.addSubview(listingImageView)
//        view.addSubview(priceTextLabel)
//        view.addSubview(priceInfoTextLabel)
//        view.addSubview(sellerTextLabel)
//        view.addSubview(sellerInfoTextLabel)
//        view.addSubview(descriptionTextLabel)
//        view.addSubview((descriptionInfoTextLabel))
        
        
//        listingScrollView.addSubview(descriptionInfoTextLabel)
        
//        setupListingImageView()
//        setupTitleTextLabel()
//        setupPriceTextLabel()
//        setupPriceInfoTextLabel()
//        setupSellerTextLabel()
//        setupSellerInfoTextLabel()
//        setupDescriptionTextLabel()
//        setupDescriptionInfoTextLabel()
    }
    
    func fetchUser() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            // for some reason uid = nil
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary)
//                self.navigationItem.title = dictionary["name"] as? String
                user.setValuesForKeys(dictionary)
            }
        }, withCancel: nil)
    }
    
    func setupNavBarLogo() {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
    }
    
    var listingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
//        scrollView.bounces = true
        scrollView.contentSize = CGSize(width: 300, height: 700)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        var contentView: UIView {
            let cv = UIView()
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
//            cv.translatesAutoresizingMaskIntoConstraints = false
            
            var titleTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "This is a really long string. Hopefully this will eventually wrap around and increase the number of rows"
                //        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
                textLabel.font = .boldSystemFont(ofSize: 18)
                textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                textLabel.numberOfLines = 0
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupTitleTextLabel() {
                titleTextLabel.leftAnchor.constraint(equalTo: cv.leftAnchor, constant: 16).isActive = true
//                titleTextLabel.rightAnchor.constraint(equalTo: cv.rightAnchor, constant: -16).isActive = true
                titleTextLabel.topAnchor.constraint(equalTo: cv.topAnchor, constant: 8).isActive = true
                titleTextLabel.widthAnchor.constraint(equalToConstant: screenWidth-32).isActive = true
                //        titleTextLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
                //        titleTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            var listingImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "Image")
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                return imageView
            }()
            
            func setupListingImageView() {
                listingImageView.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
                listingImageView.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                listingImageView.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 8).isActive = true
                listingImageView.heightAnchor.constraint(equalTo: listingImageView.widthAnchor).isActive = true
            }
            
            var priceTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "Price:"
                //        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
                textLabel.font = .boldSystemFont(ofSize: 16)
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupPriceTextLabel() {
                priceTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
                //        priceTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                priceTextLabel.topAnchor.constraint(equalTo: listingImageView.bottomAnchor, constant: 8).isActive = true
                //        priceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            var priceInfoTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "$00.00"
                textLabel.textColor = UIColor(r: 200, g: 52, b: 26)
                textLabel.font = .systemFont(ofSize: 16)
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupPriceInfoTextLabel() {
                priceInfoTextLabel.leftAnchor.constraint(equalTo: priceTextLabel.rightAnchor, constant: 8).isActive = true
                //        priceInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                priceInfoTextLabel.bottomAnchor.constraint(equalTo: priceTextLabel.bottomAnchor).isActive = true
                //        priceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            var sellerTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "Seller:"
                textLabel.font = .boldSystemFont(ofSize: 16)
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupSellerTextLabel() {
                sellerTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
                //        sellerTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                sellerTextLabel.topAnchor.constraint(equalTo: priceTextLabel.bottomAnchor, constant: 8).isActive = true
                //        sellerTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            var sellerInfoTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "Jon Snow"
                textLabel.font = .systemFont(ofSize: 16)
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupSellerInfoTextLabel() {
                sellerInfoTextLabel.leftAnchor.constraint(equalTo: sellerTextLabel.rightAnchor, constant: 8).isActive = true
                //        sellerInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                sellerInfoTextLabel.bottomAnchor.constraint(equalTo: sellerTextLabel.bottomAnchor).isActive = true
                //        sellerTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            var descriptionTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "Description:"
                textLabel.font = .boldSystemFont(ofSize: 16)
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupDescriptionTextLabel() {
                descriptionTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
                descriptionTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                //        descriptionTextLabel.topAnchor.constraint(equalTo: listingScrollView.topAnchor, constant: 8).isActive = true
                descriptionTextLabel.topAnchor.constraint(equalTo: sellerTextLabel.bottomAnchor, constant: 8).isActive = true
                //        descriptionTextLabel(equalToConstant: 30).isActive = true
            }
            
            
            var descriptionInfoTextLabel: UILabel = {
                let textLabel = UILabel()
                textLabel.text = "We the People of the United States, in Order to form a more perfect Union, establish Justice, insure domestic Tranquility, provide for the common defence, promote the general Welfare, and secure the Blessings of Liberty to ourselves and our Posterity, do ordain and establish this Constitution for the United States of America."
                textLabel.font = .systemFont(ofSize: 16)
                textLabel.numberOfLines = 0
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                return textLabel
            }()
            
            func setupDescriptionInfoTextLabel() {
                descriptionInfoTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
                descriptionInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
                descriptionInfoTextLabel.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 8).isActive = true
//                descriptionInfoTextLabel.heightAnchor.constraint(equalTo: descriptionInfoTextLabel.heightAnchor, constant: 100).isActive = true
            }
            
            cv.addSubview(titleTextLabel)
            cv.addSubview(listingImageView)
            cv.addSubview(priceTextLabel)
            cv.addSubview(priceInfoTextLabel)
            cv.addSubview(sellerTextLabel)
            cv.addSubview(sellerInfoTextLabel)
            cv.addSubview(descriptionTextLabel)
            cv.addSubview(descriptionInfoTextLabel)
            
            setupListingImageView()
            setupTitleTextLabel()
            setupPriceTextLabel()
            setupPriceInfoTextLabel()
            setupSellerTextLabel()
            setupSellerInfoTextLabel()
            setupDescriptionTextLabel()
            setupDescriptionInfoTextLabel()
            
            return cv
        }
        
        func setupContentView() {
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        
        scrollView.addSubview(contentView)
//        setupContentView()
        
        return scrollView
    }()
    
    func setupScrollView() {
        listingScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listingScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        listingScrollView.heightAnchor.constraint(equalToConstant: view.heightAnchor).active = true
        listingScrollView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        listingScrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }

//    var titleTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "This is a really long string. Hopefully this will eventually wrap around and increase the number of rows"
////        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
//        textLabel.font = .boldSystemFont(ofSize: 18)
//        textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//        textLabel.numberOfLines = 0
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupTitleTextLabel() {
//        titleTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
//        titleTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
//        titleTextLabel.topAnchor.constraint(equalTo: listingScrollView.bottomAnchor, constant: 8).isActive = true
////        titleTextLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
////        titleTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
//    lazy var listingImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Image")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return imageView
//    }()
//    
//    func setupListingImageView() {
//        listingImageView.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
//        listingImageView.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        listingImageView.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 8).isActive = true
//        listingImageView.heightAnchor.constraint(equalTo: listingImageView.widthAnchor).isActive = true
//    }
//    
//    var priceTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "Price:"
////        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
//        textLabel.font = .boldSystemFont(ofSize: 16)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupPriceTextLabel() {
//        priceTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
////        priceTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        priceTextLabel.topAnchor.constraint(equalTo: listingImageView.bottomAnchor, constant: 8).isActive = true
////        priceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
//    var priceInfoTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "$00.00"
//        textLabel.textColor = UIColor(r: 200, g: 52, b: 26)
//        textLabel.font = .systemFont(ofSize: 16)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupPriceInfoTextLabel() {
//        priceInfoTextLabel.leftAnchor.constraint(equalTo: priceTextLabel.rightAnchor, constant: 8).isActive = true
////        priceInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        priceInfoTextLabel.bottomAnchor.constraint(equalTo: priceTextLabel.bottomAnchor).isActive = true
//        //        priceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
//    var sellerTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "Seller:"
//        textLabel.font = .boldSystemFont(ofSize: 16)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupSellerTextLabel() {
//        sellerTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
////        sellerTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        sellerTextLabel.topAnchor.constraint(equalTo: priceTextLabel.bottomAnchor, constant: 8).isActive = true
////        sellerTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
//    var sellerInfoTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "Jon Snow"
//        textLabel.font = .systemFont(ofSize: 16)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupSellerInfoTextLabel() {
//        sellerInfoTextLabel.leftAnchor.constraint(equalTo: sellerTextLabel.rightAnchor, constant: 8).isActive = true
////        sellerInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        sellerInfoTextLabel.bottomAnchor.constraint(equalTo: sellerTextLabel.bottomAnchor).isActive = true
//        //        sellerTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    
//    var descriptionTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "Description:"
//        textLabel.font = .boldSystemFont(ofSize: 16)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupDescriptionTextLabel() {
//        descriptionTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
//        descriptionTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
////        descriptionTextLabel.topAnchor.constraint(equalTo: listingScrollView.topAnchor, constant: 8).isActive = true
//        descriptionTextLabel.topAnchor.constraint(equalTo: sellerTextLabel.bottomAnchor, constant: 8).isActive = true
//        //        descriptionTextLabel(equalToConstant: 30).isActive = true
//    }
//    
//
//    var descriptionInfoTextLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.text = "We the People of the United States, in Order to form a more perfect Union, establish Justice, insure domestic Tranquility, provide for the common defence, promote the general Welfare, and secure the Blessings of Liberty to ourselves and our Posterity, do ordain and establish this Constitution for the United States of America. We the People of the United States, in Order to form a more perfect Union, establish Justice, insure domestic Tranquility, provide for the common defence, promote the general Welfare, and secure the Blessings of Liberty to ourselves and our Posterity, do ordain and establish this Constitution for the United States of America."
//        textLabel.font = .systemFont(ofSize: 16)
//        textLabel.numberOfLines = 0
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textLabel
//    }()
//    
//    func setupDescriptionInfoTextLabel() {
//        descriptionInfoTextLabel.leftAnchor.constraint(equalTo: titleTextLabel.leftAnchor).isActive = true
//        descriptionInfoTextLabel.rightAnchor.constraint(equalTo: titleTextLabel.rightAnchor).isActive = true
//        descriptionInfoTextLabel.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 8).isActive = true
//        //        descriptionTextLabel(equalToConstant: 30).isActive = true
//    }
    

    
//    let cellId = "cellId"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
//                                                           style: .plain,
//                                                           target: self,
//                                                           action: #selector(handleLogout))
//        
//        //        let image = UIImage(named: "new_message")
//        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
//        
//        // user is not logged in
//        checkIfUserIsLoggedIn()
//        
//        tableView.register(ListingCell.self, forCellReuseIdentifier: cellId)
//        
//        observeListings()
//    }
//    
//    var listings = [Listing]()
//    var listingsDictionary = [String: Listing]()
//    
//    func observeListings() {
//        let ref = FIRDatabase.database().reference().child("listings")
//        ref.observe(.childAdded, with: { (snapshot) in
//            
//            //            print("Fetching...")
//            //            print(snapshot)
//            
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let listing = Listing()
//                listing.setValuesForKeys(dictionary)
//                self.listings.append(listing)
//                
//                self.listings.sort(by: { (message1, message2) -> Bool in
//                    return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
//                })
//                
//                // this will crash because of background thread, so let's call this on dispatch_async main thread
//                DispatchQueue.main.async(execute: {
//                    self.tableView.reloadData()
//                })
//            }
//        }, withCancel: nil)
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listings.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListingCell
//        
//        let listing = listings[indexPath.row]
//        cell.listing = listing
//        //        print(indexPath.row)
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    //    func handleNewMessage() {
//    //        let newMessageController = NewMessageController()
//    //        newMessageController.messagesController = self
//    //        let navController = UINavigationController(rootViewController: newMessageController)
//    //        present(navController, animated: true, completion: nil)
//    //    }
//    
//    func checkIfUserIsLoggedIn() {
//        if FIRAuth.auth()?.currentUser?.uid == nil {
//            perform(#selector(handleLogout), with: nil, afterDelay: 0)
//        } else {
//            fetchUserAndSetupNavBarTitle()
//        }
//    }
//    
//    func fetchUserAndSetupNavBarTitle() {
//        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
//            // for some reason uid = nil
//            return
//        }
//        
//        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            //            print(snapshot)
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                self.navigationItem.title = dictionary["name"] as? String
//                
//                let user = User()
//                
//                user.setValuesForKeys(dictionary)
//                self.setupNavBarWithUser(user: user)
//            }
//        }, withCancel: nil)
//    }
//    
//    func setupNavBarWithUser(user: User) {
//        let titleView = UIView()
//        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        
//        let logoImageView = UIImageView()
//        logoImageView.image = UIImage(named: "Logo")
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        titleView.addSubview(logoImageView)
//        
//        //        titleView.backgroundColor = UIColor.red
//        
//        /*
//         let containerView = UIView()
//         containerView.translatesAutoresizingMaskIntoConstraints = false
//         titleView.addSubview(containerView)
//         
//         let profileImageView = UIImageView()
//         profileImageView.translatesAutoresizingMaskIntoConstraints = false
//         profileImageView.contentMode = .scaleAspectFill
//         profileImageView.layer.cornerRadius = 20
//         profileImageView.clipsToBounds = true
//         if let profileImageUrl = user.profileImageUrl {
//         profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
//         }
//         
//         containerView.addSubview(profileImageView)
//         
//         // ios 10 constraints
//         profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//         profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//         profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//         profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//         
//         let nameLabel = UILabel()
//         containerView.addSubview(nameLabel)
//         nameLabel.text = user.name
//         nameLabel.translatesAutoresizingMaskIntoConstraints = false
//         
//         // constraints
//         nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
//         nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//         nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//         nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
//         
//         containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
//         containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
//         */
//        
//        logoImageView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
//        
//        self.navigationItem.titleView = titleView
//        
//        //        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
//    }
//    
//    func showChatController(user: User) {
//        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        chatLogController.user = user
//        navigationController?.pushViewController(chatLogController, animated: true)
//    }
//    
//    
    func handleBuy() {
        
        let alert = UIAlertController(title: "Buy Now", message: "Do you wish to buy this listing and contact the seller to negotiate?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        do {
//            try FIRAuth.auth()?.signOut()
//        } catch let logoutError {
//            print(logoutError)
//        }
//        
//        let loginController = LoginController()
//        loginController.homeController = self
//        present(loginController, animated: true, completion: nil)

    }
}
