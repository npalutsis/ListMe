//
//  ScrollViewController.swift
//  MobileComputing
//
//  Created by Nick Palutsis on 4/29/17.
//  Copyright © 2017 Nick Palutsis. All rights reserved.
//

import UIKit
import Firebase

class ScrollViewController: UIScrollView {
    
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<colors.count {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.pagingEnabled = true
            
            var subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * CGFloat(colors.count), self.scrollView.frame.size.height)
    }

}
