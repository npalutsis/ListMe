//
//  NewListingController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit

class NewListingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        navigationItem.title = "New Listing"

        view.addSubview(listingImageView)
        view.addSubview(imageTextLabel)
        view.addSubview(titleTextLabel)
        view.addSubview(titleTextField)
        
        setupListingImageView()
        setupImageTextLabel()
        setupTitleTextLabel()
        setupTitleTextField()
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleSubmit() {
        // Check fields are filled out
        // Post to firebase
    }
    
    lazy var listingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "camera")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    func setupListingImageView() {
        // need x, y, width, height constraints
        listingImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        listingImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
        listingImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        listingImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var imageTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Add a photo for your listing..."
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupImageTextLabel() {
        imageTextLabel.leftAnchor.constraint(equalTo: listingImageView.rightAnchor, constant: 12).isActive = true
        imageTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageTextLabel.centerYAnchor.constraint(equalTo: listingImageView.centerYAnchor).isActive = true
    }
    
    var titleTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "  Title"
        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupTitleTextLabel() {
        titleTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleTextLabel.topAnchor.constraint(equalTo: listingImageView.bottomAnchor, constant: 8).isActive = true
        titleTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "Enter the title of your listing..."
        tf.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setupTitleTextField() {
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 8).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // Change image
    func handleSelectImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
            listingImageView.image = selectedImage
            listingImageView.contentMode = .scaleAspectFit
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
}
