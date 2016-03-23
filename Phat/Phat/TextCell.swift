//
//  TextCell.swift
//  Phat
//
//  Created by Reis Sirdas on 3/22/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit
import Parse

class TextCell: UITableViewCell {
   
    @IBOutlet weak var messageLabel: UILabel!

    var message: PFObject! {
        didSet {
            self.messageLabel.text = message["text"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
