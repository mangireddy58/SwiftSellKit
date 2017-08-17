//
//  acceptanceCell.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 31/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class acceptanceCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var cost: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
