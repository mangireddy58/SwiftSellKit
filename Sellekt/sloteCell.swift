//
//  sloteCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 10/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class sloteCell: UITableViewCell {
    @IBOutlet weak var sloteTextField: UITextField!

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var commentTextFiled: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
