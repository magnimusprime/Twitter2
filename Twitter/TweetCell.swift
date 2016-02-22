//
//  TweetCell.swift
//  Twitter
//
//  Created by Maggie Gates on 2/21/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate{
    
    optional func tweetCell(tweetCell: TweetCell, didChangeValue value: Bool)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    weak var delegate: TweetCellDelegate?
    
    let favoritePressedImage = UIImage(named: "like-action-on.png")! as UIImage
    
    
    var tweet: Tweet!{
        
        didSet{
            nameLabel.text = String(tweet.user!.name!)
            usernameLabel.text = "@\(tweet.user!.screenname)"
            tweetLabel.text = tweet.text as? String
            profileImageView.setImageWithURL(tweet.user!.profileUrl!)
            timeLabel.text = calculateTimeStamp(tweet.timestamp!.timeIntervalSinceNow)
            
        }
    }
    
    
    //All credit for this method goes to Aaron Laub who got it from David Wayman, slack @dwayman
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
        favoriteButton.addTarget(self, action: "favoriteValueChanged", forControlEvents:UIControlEvents.TouchUpInside)
        
        retweetButton.addTarget(self, action: "retweetValueChanged", forControlEvents:UIControlEvents.TouchUpInside)
        
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    func favoriteValueChanged()
    {
        
        if delegate != nil{
            
            delegate?.tweetCell?(self, didChangeValue: favoriteButton.selected)
            
        }
        
        favoriteButton.selected = true
        
    }
    func retweetValueChanged()
    {
        
        if delegate != nil{
            
            delegate?.tweetCell?(self, didChangeValue: retweetButton.selected)
            
        }
        
        retweetButton.selected = true
        
    }
    
    
    
}