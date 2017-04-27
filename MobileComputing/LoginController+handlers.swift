//
//  LoginController+handlers.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/23/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleRegister() {
//        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
//            print("Form is not valid")
//            return
//        }
//        
//        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
//            
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            guard let uid = user?.uid else {
//                return
//            }
//            
//            // successfully authenticated user
//            let imageName = NSUUID().uuidString
//            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
//            
//            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
//                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
//                    
//                    if error != nil {
//                        print(error!)
//                        return
//                    }
//                    
//                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
//                        
//                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
//                    }
//                })
//            }
//            
//            
//        })
        let alert = UIAlertController(title: "Sign Up Error", message: "ListMe requires a college email in order to access the application. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: String]) {
//        let ref = FIRDatabase.database().reference(fromURL: "https://listme-b5d36.firebaseio.com/")
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)

        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
//            self.homeController?.fetchUserAndSetupNavBarTitle()
            let user = User()
            // this setter potentially crashes if keys don't match
            user.setValuesForKeys(values)
            self.homeController?.setupNavBarWithUser(user: user)
            
            self.dismiss(animated: true, completion: nil)
            
        })

    }
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
            print("editted image")
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
            print("original image")
        } else {
            print("could not get image")
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
    
}
