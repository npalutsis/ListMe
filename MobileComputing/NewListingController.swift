//
//  NewListingController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

class NewListingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        view.addSubview(profileImageView)
        view.addSubview(listingImageView)
        
        setupProfileImageView()
        setupListingImageView()
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newListing")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var listingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    func setupProfileImageView() {
        // need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupListingImageView() {
        // need x, y, width, height constraints
        listingImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        listingImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        listingImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        } else {
            print("could not get image")
        }
        
        if let selectedImage = selectedImageFromPicker {
            listingImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
}
