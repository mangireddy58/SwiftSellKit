//
//  venderQuatationCell.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 28/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class venderQuatationCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var venderName: UILabel!
    @IBOutlet var away: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var timeVender: UILabel!
    @IBOutlet var tickImg: UIButton!
    @IBOutlet var starImg1: UIImageView!
    @IBOutlet var starImg2: UIImageView!
    @IBOutlet var starImg3: UIImageView!
    @IBOutlet var starImg4: UIImageView!
    @IBOutlet var starImg5: UIImageView!
    @IBOutlet var rating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
