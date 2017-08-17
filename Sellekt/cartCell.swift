 //
//  cartCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 26/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {

    @IBOutlet weak var venderName: UILabel!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var pluse: UIButton!
    @IBOutlet weak var minuse: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
