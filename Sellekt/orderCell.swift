//
//  orderCell.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 07/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class orderCell: UITableViewCell {
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
