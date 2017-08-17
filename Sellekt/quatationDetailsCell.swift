//
//  quatationDetailsCell.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 31/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class quatationDetailsCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!

    @IBOutlet var qty: UILabel!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
