//
//  MyOrderCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {

    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
            
           // btnDetail.layer.cornerRadius = btnDetail.frame.size.width/2
          //  btnDetail.clipsToBounds = true
            
        
        // Initialization code
    }    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

