//
//  deliveryAddCell.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 10/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit
import MapKit
class deliveryAddCell: UITableViewCell {

    @IBOutlet weak var addImg1: UIButton!
    @IBOutlet weak var addImg2: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var contry: UITextField!
    @IBOutlet weak var city: UITextField!
     @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var address: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
