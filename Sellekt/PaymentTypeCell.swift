//
//  PaymentTypeCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 10/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class PaymentTypeCell: UITableViewCell {

    @IBOutlet weak var TotalLbl: UILabel!
    @IBOutlet weak var ShippingRateLbl: UILabel!
    @IBOutlet weak var cartTotalLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
