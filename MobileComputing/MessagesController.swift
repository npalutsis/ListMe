//
//  LoginController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/5/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleRefresh))
        
        let image = UIImage(named: "new_message")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        // user is not logged in
        checkIfUserIsLoggedIn()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
//        observeMessages()
        observeUserMessages()
    }
    
    func observeUserMessages() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let ref = FIRDatabase.database().reference().child("user_messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messagesReference = FIRDatabase.database().reference().child("messages").child(messageId)
            
            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message()
                    message.setValuesForKeys(dictionary)
                    self.messages.append(message)
                    
                    if let chatPartnerId = message.chatPartnerId() {
                        self.messagesDictionary[chatPartnerId] = message
                        
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                        })
                    }
                    
                    // this will crash because of background thread, so let's call this on dispatch_async main thread
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    func observeMessages() {
        let ref = FIRDatabase.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                
                if let toId = message.toId {
                    self.messagesDictionary[toId] = message
                    
                    self.messages = Array(self.messagesDictionary.values)
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                    })
                }
                
                // this will crash because of background thread, so let's call this on dispatch_async main thread
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let message = messages[indexPath.row]
        cell.message = message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let user = User()
            user.id = chatPartnerId
            user.setValuesForKeys(dictionary)
            self.showChatController(user: user)
            
        }, withCancel: nil)
    }
    
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        newMessageController.messagesController = self
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
//            fetchUserAndSetupNavBarTitle()
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            // for some reason uid = nil
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
                
                let user = User()
                
                user.setValuesForKeys(dictionary)
                self.setupNavBarWithUser(user: user)
            }
        }, withCancel: nil)
    }
    
    func setupNavBarWithUser(user: User) {
        
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
 
        
        //        titleView.backgroundColor = UIColor.red
        
        /*
         let containerView = UIView()
         containerView.translatesAutoresizingMaskIntoConstraints = false
         titleView.addSubview(containerView)
         
         let profileImageView = UIImageView()
         profileImageView.translatesAutoresizingMaskIntoConstraints = false
         profileImageView.contentMode = .scaleAspectFill
         profileImageView.layer.cornerRadius = 20
         profileImageView.clipsToBounds = true
         if let profileImageUrl = user.profileImageUrl {
         profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
         }
         
         containerView.addSubview(profileImageView)
         
         // ios 10 constraints
         profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
         profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
         profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
         profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
         
         let nameLabel = UILabel()
         containerView.addSubview(nameLabel)
         nameLabel.text = user.name
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         
         // constraints
         nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
         nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
         nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
         nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
         
         containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
         containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
         */
        
//        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
    }
    
    func showChatController(user: User) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
//        navigationController?.pushViewController(chatLogController, animated: true)
        let navController = UINavigationController(rootViewController: chatLogController)
        present(navController, animated: true, completion: nil)
    }    
    
    func handleLogout() {
        
        do {
            handleRefresh()
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
//        loginController.messagesController = self
        present(loginController, animated: true, completion: nil)
    }
    
    func handleRefresh() {
        print("\nRefreshing...\n")
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        observeUserMessages()
    }
}
