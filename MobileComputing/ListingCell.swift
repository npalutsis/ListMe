//
//  ListingCell.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/24/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

class ListingCell: UITableViewCell {
    
    var listing: Listing? {
        didSet {
            if let id = listing?.id {
                let ref = FIRDatabase.database().reference().child("listings").child(id)
                ref .observeSingleEvent(of: .value, with: { (snapshot) in

//                    print(snapshot.key)

                    if let dictionary = snapshot.value as? [String: AnyObject] {
//                        self.textLabel?.text = dictionary["title"] as? String
                        self.titleLabel.text = self.listing?.title
                        self.detailLabel.text = self.listing?.text
                        self.priceLabel.text = self.listing?.price

                        if let listingImageUrl = dictionary["listingImageUrl"] as? String {
                            self.listingImageView.loadImageUsingCacheWithUrlString(urlString: listingImageUrl)
                        }
                    }
                }, withCancel: nil)
            }
            
//            detailTextLabel?.numberOfLines = 3
//            detailTextLabel?.text = listing?.text
            
//            priceLabel.text = listing?.price
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        textLabel?.frame = CGRect(x: 100, y: textLabel!.frame.origin.y - 8, width: textLabel!.frame.width, height: textLabel!.frame.height)
//        
//        detailTextLabel?.frame = CGRect(x: 100, y: detailTextLabel!.frame.origin.y - 20, width: detailTextLabel!.frame.width - 80, height: detailTextLabel!.frame.height * 2)
//    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Description of listing"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let listingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$00.00"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(listingImageView)
        addSubview(priceLabel)
        
        // ios 10 constraint anchors
        // need x, y, width, height anchors
        listingImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        listingImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        listingImageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -16).isActive = true
        listingImageView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -16).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: listingImageView.rightAnchor, constant: 8).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: listingImageView.topAnchor, constant: 4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        detailLabel.leftAnchor.constraint(equalTo: listingImageView.rightAnchor, constant: 8).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        detailLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
