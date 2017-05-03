//
//  ListingPageController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/29/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase
    
var selectedListingTitle = ""
var selectedListingImageUrl = "https://firebasestorage.googleapis.com/v0/b/listme-b5d36.appspot.com/o/profile_images%2F76C5AC33-34C6-46C2-BA41-06FA866840A3.png?alt=media&token=72748a49-ed90-4f00-ac68-c413781bc73e"
var selectedListingPrice = ""
var selectedListingSellerId = ""
var selectedListingSellerName = ""
var selectedListingDescription = ""

class ListingPageController: UIViewController {
    
    var listing: Listing? {
        didSet {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))

            observeListing()
        }
    }
    
    func observeListing() {
        
//        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
//            return
//        }
        
//        let ref = FIRDatabase.database().reference().child("listings").child(listingid)
//        userMessagesRef.observe(.childAdded, with: { (snapshot) in
//            
//            let messageId = snapshot.key
//            let messagesRef = FIRDatabase.database().reference().child("messages").child(messageId)
//            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                guard let dictionary = snapshot.value as? [String: AnyObject] else {
//                    return
//                }
//                
//                let message = Message()
//                // potential of crashing if keys don't match
//                message.setValuesForKeys(dictionary)
//                
//                if message.chatPartnerId() == self.user?.id {
//                    self.messages.append(message)
//                    
//                    DispatchQueue.main.async(execute: {
//                        self.collectionView?.reloadData()
//                    })
//                }
//                
//            }, withCancel: nil)
//            
//        }, withCancel: nil)
    }
    
    func fetchUser() {
        guard let uid = listing?.sellerId else {
            // for some reason uid = nil
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary)
                selectedListingSellerName = (dictionary["name"] as? String)!
//                user.setValuesForKeys(dictionary)
                print(selectedListingSellerName)
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
                textLabel.text = selectedListingTitle
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
                textLabel.text = selectedListingPrice
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
                
//                let uid = selectedListingSellerId
//                
//                FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                    if let dictionary = snapshot.value as? [String: AnyObject] {
//                        print(dictionary)
//                        selectedListingSellerName = (dictionary["name"] as? String)!
//                        //                user.setValuesForKeys(dictionary)
//                    }
//                }, withCancel: nil)
//                
                textLabel.text = selectedListingSellerName
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
                textLabel.text = selectedListingDescription
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
            
            print("printing: ", selectedListingImageUrl)
            
            listingImageView.loadImageUsingCacheWithUrlString(urlString: selectedListingImageUrl)
            
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
    
    func handleBuy() {
        
        let alert = UIAlertController(title: "Buy Now", message: "Do you wish to buy this listing and contact the seller to negotiate?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
            self.handleConnectToSeller()
        }))
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
    
    func handleConnectToSeller() {
        
        if selectedListingSellerId != "" {
//            FIRDatabase.database().reference().child("users").child(selectedListingSellerId).observeSingleEvent(of: .value, with: { (snapshot) in
//                            print(snapshot)
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                    self.navigationItem.title = dictionary["name"] as? String
//                    
//                    let user = User()
//                    user.id = snapshot.key
//                    
//                    user.setValuesForKeys(dictionary)
//                }
//            }, withCancel: nil)
//            
//            print("User: ", user)
//            
//            let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//            chatLogController.user = user
//            //        navigationController?.pushViewController(chatLogController, animated: true)
//            let navController = UINavigationController(rootViewController: chatLogController)
//            present(navController, animated: true, completion: nil)
//            
            
            let ref = FIRDatabase.database().reference().child("users").child(selectedListingSellerId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                let user = User()
                user.id = selectedListingSellerId
                user.setValuesForKeys(dictionary)
//                self.showChatController(user: user)
                let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
                chatLogController.user = user
                //        navigationController?.pushViewController(chatLogController, animated: true)
                let navController = UINavigationController(rootViewController: chatLogController)
                self.present(navController, animated: true, completion: nil)
                
            }, withCancel: nil)
        }
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarLogo()
//        fetchUser()
        
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: #selector(handleBuy))
                
        view.addSubview(listingScrollView)
        setupScrollView()
    }
}
