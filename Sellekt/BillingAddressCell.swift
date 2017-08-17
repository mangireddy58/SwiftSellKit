//
//  BillingAddressCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 10/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class BillingAddressCell: UITableViewCell {

    @IBOutlet weak var ContactLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
