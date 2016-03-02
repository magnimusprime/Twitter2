//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Maggie Gates on 2/28/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.setImageWithURL((tweet!.user?.profileUrl)!)
        
        
        
        nameLabel.text = tweet!.user?.name as String?
        handleLabel.text = "@\((tweet!.user?.screenname)!)"
        tweetLabel.text = tweet!.text as String?
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let userProfileViewController = segue.destinationViewController as! ProfileViewController
        
        userProfileViewController.tweet = tweet
    }
    
}
