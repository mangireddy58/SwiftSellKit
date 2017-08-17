//
//  MyquotationCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class MyquotationCell: UITableViewCell {

    @IBOutlet weak var btnViewDetail: UIButton!
    @IBOutlet weak var lblitemName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSrNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
