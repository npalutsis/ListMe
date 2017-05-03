//
//  NewListingController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

let user = User()

class NewListingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(handleClear))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
        navigationItem.title = "New Listing"

        view.addSubview(listingImageView)
        view.addSubview(imageTextLabel)
        view.addSubview(titleTextLabel)
        view.addSubview(titleTextField)
        view.addSubview(categoryTextLabel)
        view.addSubview(categoryTextField)
        view.addSubview(conditionTextLabel)
        view.addSubview(conditionTextField)
        view.addSubview(priceTextLabel)
        view.addSubview(priceTextField)
        view.addSubview(descriptionTextLabel)
        view.addSubview(descriptionTextView)
        
        setupListingImageView()
        setupImageTextLabel()
        setupTitleTextLabel()
        setupTitleTextField()
        setupCategoryTextLabel()
        setupCategoryTextField()
        setupConditionTextLabel()
        setupConditionTextField()
        setupPriceTextLabel()
        setupPriceTextField()
        setupDescriptionTextLabel()
        setupDescriptionTextView()
    }
    
    func handleClear() {
//        dismiss(animated: true, completion: nil)
        listingImageView.image = UIImage(named: "camera")
        titleTextField.text = ""
        categoryTextField.text = ""
        conditionTextField.text = ""
        priceTextField.text = ""
        descriptionTextView.text = ""
    }
    
    func fetchUser() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            // for some reason uid = nil
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary)
                self.navigationItem.title = dictionary["name"] as? String
                user.setValuesForKeys(dictionary)
            }
        }, withCancel: nil)
    }
    
    func handleSubmit() {
        let ref = FIRDatabase.database().reference().child("listings")
        let childRef = ref.childByAutoId()
        
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("listing_images").child("\(imageName).png")
        
        if let listingImage = listingImageView.image, let uploadData = UIImageJPEGRepresentation(listingImage, 0.1) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in

                if error != nil {
                    print(error!)
                    return
                }
                
                let timestamp = NSDate().timeIntervalSince1970
                let sellerId = user.id
                let domain = user.domain
                let title = self.titleTextField.text
                let category = self.categoryTextField.text
                let condition = self.conditionTextField.text
                let price = self.priceTextField.text
                let description = self.descriptionTextView.text
                let listingImageUrl = metadata?.downloadURL()?.absoluteString
                
                if title != "" &&
                    category != "" &&
                    condition != "" &&
                    price != "" &&
                    description != "" &&
                    self.listingImageView.image != UIImage(named: "camera") {

                    let values = ["title": title as Any,
                                  "category": category as Any,
                                  "condition": condition as Any,
                                  "price": price as Any,
                                  "text": description as Any,
                                  "sellerId": sellerId as Any,
                                  "domain": domain as Any,
                                  "listingImageUrl": listingImageUrl as Any,
                                  "timestamp": timestamp] as [String : Any]
                        
                    childRef.setValue(values)
                    
                    let alert = UIAlertController(title: "Success", message: "Your listing was successfully posted", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.handleClear()
                    
                } else {
                    let alert = UIAlertController(title: "Incomplete Fields", message: "Please make sure all available fields are completed before submitting.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            })
        }
        
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
        tf.setLeftPaddingPoints(10)
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
    
    var categoryTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "  Category"
        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupCategoryTextLabel() {
        categoryTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        categoryTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        categoryTextLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8).isActive = true
        categoryTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let categoryTextField: UITextField = {
        let tf = UITextField()
        tf.setLeftPaddingPoints(10)
        tf.placeholder = "Choose a category for your listing..."
        tf.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setupCategoryTextField() {
        categoryTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        categoryTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        categoryTextField.topAnchor.constraint(equalTo: categoryTextLabel.bottomAnchor, constant: 8).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var conditionTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "  Condition"
        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupConditionTextLabel() {
        conditionTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        conditionTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        conditionTextLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 8).isActive = true
        conditionTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let conditionTextField: UITextField = {
        let tf = UITextField()
        tf.setLeftPaddingPoints(10)
        tf.placeholder = "Choose a condition for your listing..."
        tf.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setupConditionTextField() {
        conditionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        conditionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        conditionTextField.topAnchor.constraint(equalTo: conditionTextLabel.bottomAnchor, constant: 8).isActive = true
        conditionTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var priceTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "  Price"
        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupPriceTextLabel() {
        priceTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        priceTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        priceTextLabel.topAnchor.constraint(equalTo: conditionTextField.bottomAnchor, constant: 8).isActive = true
        priceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.setLeftPaddingPoints(10)
        tf.placeholder = "Choose a price for your listing..."
        tf.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setupPriceTextField() {
        priceTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        priceTextField.topAnchor.constraint(equalTo: priceTextLabel.bottomAnchor, constant: 8).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    var descriptionTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "  Description"
        textLabel.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }()
    
    func setupDescriptionTextLabel() {
        descriptionTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 8).isActive = true
        descriptionTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
//        tf.setLeftPaddingPoints(10)
//        tf.placeholder = "Describe your listing..."
        tv.layer.borderColor = UIColor(r: 230, g: 230, b: 230).cgColor
        tv.font = .systemFont(ofSize: 16)
        tv.layer.cornerRadius = 8
        tv.layer.borderWidth = 2
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    func setupDescriptionTextView() {
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 8).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
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
    
    // returns the number of 'columns' to display.\
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..\
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
