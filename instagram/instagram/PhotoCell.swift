//
//  PhotoCell.swift
//  instagram
//
//  Created by Reis Sirdas on 3/6/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            self.photoView.file = post["image"] as? PFFile
            self.photoView.loadInBackground()
            self.captionLabel.text = post["caption"]
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
