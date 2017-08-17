//
//  uploadListCell.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 28/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class uploadListCell: UITableViewCell,UITextFieldDelegate {
 
    @IBOutlet var uploadBtn: UIButton!
    @IBOutlet var imgName: UITextField!
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var productName: UITextField!
    @IBOutlet var qtyTxt: UITextField!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var addImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
                if textField == self.productName
        {
            self.productName.resignFirstResponder()
            self.addBtn.isSelected = true
        }
        // textField.resignFirstResponder()i
        
        return true
    }
    // MARK: DKDropMenuDelegate
    func itemSelected(withIndex: Int, name: String) {
        print("\(name) selected");
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
