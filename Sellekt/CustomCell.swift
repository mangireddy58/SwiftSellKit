//
//  CustomCell.swift
//  Expandable
//
//  Created by Gabriel Theodoropoulos on 28/10/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func dateWasSelected(_ selectedDateString: String)
    
    func maritalStatusSwitchChangedState(_ isOn: Bool)
    
    func textfieldTextWasChanged(_ newText: String, parentCell: CustomCell)
    
    func sliderDidChangeValue(_ newSliderValue: String)
}

class CustomCell: UITableViewCell, UITextFieldDelegate {

    // MARK: IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var lblSwitchLabel: UILabel!
    
    @IBOutlet weak var swMaritalStatus: UISwitch!
    
    @IBOutlet weak var slExperienceLevel: UISlider!
    
    
    // MARK: Constants
    
    let bigFont = UIFont(name: "Avenir-Book", size: 17.0)
    
    let smallFont = UIFont(name: "Avenir-Light", size: 17.0)
    
    let primaryColor = UIColor.black
    
    let secondaryColor = UIColor.lightGray
    
    
    // MARK: Variables
    
    var delegate: CustomCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if textLabel != nil {
            textLabel?.font = bigFont
            textLabel?.textColor = primaryColor
        }
        
        if detailTextLabel != nil {
            detailTextLabel?.font = smallFont
            detailTextLabel?.textColor = secondaryColor
        }
        
        if textField != nil {
            textField.font = bigFont
            textField.delegate = self
        }
        
        if lblSwitchLabel != nil {
            lblSwitchLabel.font = bigFont
        }
        
        if slExperienceLevel != nil {
            slExperienceLevel.minimumValue = 0.0
            slExperienceLevel.maximumValue = 10.0
            slExperienceLevel.value = 0.0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: IBAction Functions
    
    @IBAction func setDate(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = dateFormatter.string(from: datePicker.date)
        
        if delegate != nil {
            delegate.dateWasSelected(dateString)
        }
    }
    
    @IBAction func handleSwitchStateChange(_ sender: AnyObject) {
        if delegate != nil {
            delegate.maritalStatusSwitchChangedState(swMaritalStatus.isOn)
        }
    }
    
    
    @IBAction func handleSliderValueChange(_ sender: AnyObject) {
        if delegate != nil {
            delegate.sliderDidChangeValue("\(Int(slExperienceLevel.value))")
        }
    }
    
    
    // MARK: UITextFieldDelegate Function
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if delegate != nil {
            delegate.textfieldTextWasChanged(textField.text!, parentCell: self)
        }
        
        return true
    }
    
}
