//
//  AcceptanceVCCellTableViewCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 05/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class AcceptanceVCCellTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPaynow: UIButton!
    @IBOutlet weak var amtLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
