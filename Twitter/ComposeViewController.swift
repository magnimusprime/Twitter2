//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Maggie Gates on 2/28/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var textCount: UILabel!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextField.delegate = self
        
        profileImage.setImageWithURL((User.currentUser?.profileUrl)!)
        
        nameLabel.text = User.currentUser?.name as String?
        handleLabel.text = "@\((User.currentUser?.screenname)!)"
        
        
    }
    
    @IBAction func updateStatusAction(sender: AnyObject) {
        
        print("tweet button pressed")
        
        let tweetStatus = tweetTextField.text!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        print(tweetStatus)
        
        TwitterClient.sharedInstance.tweetWithCompletion(["status": tweetStatus]) { (tweet, error) -> () in
            
            self.view.endEditing(true)
            
            
            User.currentUser?.tweeted()
            print(tweetStatus)
        }
    }
}