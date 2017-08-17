//
//  FAVCellTableViewCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class FAVCellTableViewCell: UITableViewCell {

    @IBAction func btndeleteAction(_ sender: Any) {
    }
    @IBAction func btnviewdetailAction(_ sender: Any) {
    }
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgfavProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgfavProduct.layer.masksToBounds=true
        imgfavProduct.layer.borderWidth=0.5
        imgfavProduct.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
