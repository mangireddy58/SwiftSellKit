//
//  ChatCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblshortMsg: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
